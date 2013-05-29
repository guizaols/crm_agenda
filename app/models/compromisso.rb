class Compromisso < ActiveRecord::Base


  validates_presence_of :data,:hora,:descricao,:pessoa,:tipo_compromisso,:message=>"deve ser preenchido"
  data_br_field :data
  belongs_to :usuario
 belongs_to :usuario, :class_name => 'Usuario', :foreign_key => 'agendado_por'
  belongs_to :pessoa
  attr_accessor :data_tempo,:hora_do_compromisso_em_minutos
  belongs_to :tipo_compromisso
  belongs_to :entidade

  HORAS = ["07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30"]

  ANDAMENTO = 1
  FINALIZADO = 2
   MES = {
      1=>"Janeiro",
      2=>"Fevereiro",
      3=>"Março",
      4=>"Abril",
      5=>"Maio",
      6=>"Junho",
      7=>"Julho",
      8=>"Agosto",
      9=>"Setembro",
      10=>"Outubro",
      11=>"Novembro",
      12=>"Dezembro",
    }
  attr_accessor :pessoa_nome

  STATUS = {1=>"Andamento", 2=>"Finalizado"}
  HUMANIZED_ATTRIBUTES = {
    :nome => "O campo Nome",
    :data => "O campo Data",
    :hora => "O campo Hora",
    :descricao => "O campo Descrição",
    :usuario => "O campo Usuário",
    :pessoa => "O campo Pessoa"
  }

  def initialize(attributes = {})
    attributes['data'] ||= Date.today
    attributes['hora'] ||= "00:00"
    attributes['status'] ||= ANDAMENTO
    super
  end

  def before_validation
    self.nome = self.tipo_compromisso.nome unless self.tipo_compromisso.blank?
  end


  def hora_do_compromisso_em_minutos
    split_horas = self.hora.split(":")
    hora = split_horas.first.to_i * 60
    minuto = split_horas.last.to_i
    hora+minuto
  end

  def self.lista_usuarios_de_uma_entidade(entidade_id)
    Usuario.find_all_by_entidade_id(entidade_id).collect{|x| ["#{x.name} - #{x.cargo}",x.id]}
  end

  def status_verbose
    STATUS[self.status]
  end

  def data_tempo
    DateTime.strptime("#{self.data.to_date.strftime("%Y/%m/%d")} #{self.hora}:00", "%Y/%m/%d %H:%M:%S")
  end

  def self.retorna_para_grafico(usuario)
    retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i =0
    data_inicio = Date.new(Date.today.year,Date.today.month,1)
    data_final = (Date.new(Date.today.year,Date.today.month,31) rescue (Date.new(Date.today.year,Date.today.month,30)))

    if usuario.perfil_id == 3
        compromissos = Compromisso.find(:all,:conditions=>["data >= ? AND data <= ?",data_inicio,data_final]).group_by(&:entidade_id)
    else
        compromissos = Compromisso.find(:all,:include=>[:usuario],:conditions=>["data >= ? AND data <= ? AND usuarios.entidade_id = ?",data_inicio,data_final,usuario.entidade_id]).group_by(&:usuario_id)
      
    end
    compromissos.each_with_index do |compromisso,index|
      
      if usuario.perfil_id !=3
      dados_eixo_x << "[#{index}.5,'#{(Usuario.find compromisso.first).name}' ]"
      else
              dados_eixo_x << "[#{index}.5,'#{(Entidade.find compromisso.first).nome}' ]"

      end

      dados_eixo_y << "{data: [[#{index},0],[#{index},#{compromisso.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end

  
  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def validate
    #errors.add "Já existe um compromisso nesta data e neste horário para este usuário, por isso este compromisso" if usuario_ocupado?
  end

  def usuario_ocupado?
    r = Compromisso.find(:all,:conditions=>["usuario_id = ? AND hora = ? AND data = ?",self.usuario_id,self.hora,self.data.to_date])
    if r.blank?
      false
    else
      true
    end
    
  end

  def self.retorna_compromissos_do_dia(data,usuario, mes = Date.today.month)
    u = Usuario.find usuario.id
    if u.perfil_id == Usuario::VENDEDOR || u.perfil_id == Usuario::RECEPCIONISTA || u.perfil_id == Usuario::TELEMARKETING
       Compromisso.all(:conditions=>["data = ? AND MONTH(data) = ? AND usuario_id=?",data.to_date,mes,usuario]).sort_by(&:data_tempo) rescue Compromisso.all(:conditions=>["data = ?","15/07/2010".to_date])
     elsif u.perfil_id == Usuario::ADMINISTRADOR_CONCESSIONARIA
       Compromisso.all(:include=>[:usuario],:conditions=>["data = ? AND MONTH(data) = ? AND usuarios.entidade_id=?",data.to_date,mes,usuario.entidade_id]).sort_by(&:data_tempo) rescue Compromisso.all(:conditions=>["data = ?","15/07/2010".to_date])
    else
      Compromisso.all(:conditions=>["data = ? AND MONTH(data) = ?",data.to_date,mes]).sort_by(&:data_tempo) rescue Compromisso.all(:conditions=>["data = ?",data.to_date])
    end
  end

  def self.procura_compromisso_por_funcionario(params, usuario = nil)
    params = params.dup
    data_inicial = params["data_inicial"]
    data_final = params["data_final"]
    if params["data_inicial"].blank?
      data_inicial = Date.today.to_s_br
    end
    if params["data_final"].blank?
      data_final = Date.today.to_s_br
    end
    Compromisso.find(:all,:include=>[:usuario],:conditions=>["data >= ? and data <= ? AND usuarios.entidade_id = ? ",data_inicial.to_date,data_final.to_date,usuario.entidade_id],:order=>["data DESC"]).group_by(&:usuario)
  end


  def self.grafico_dinamico(status)
     status = status.dup
      retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i =0

    if status == "atual"
      data_inicio = Date.new(Date.today.year,Date.today.month,1)
      data_final = (Date.new(Date.today.year,Date.today.month,31) rescue (Date.new(Date.today.year,Date.today.month,30)))
   elsif status == "anterior"
      data_inicio = Date.new(Date.today.year,(Date.today.month - 1),1)
      data_final = (Date.new(Date.today.year,(Date.today.month -1),31) rescue (Date.new(Date.today.year,(Date.today.month-1),30)))
    elsif status == "semana"
      
      data_inicio = Date.today - 7.days
      data_final = Date.today
    end
    compromissos = Compromisso.find(:all,:conditions=>["data >= ? AND data <= ?",data_inicio,data_final]).group_by(&:usuario_id)
    compromissos.each_with_index do |compromisso,index|
      dados_eixo_x << "[#{index}.5,'#{(Usuario.find compromisso.first).name}' ]"
      dados_eixo_y << "{data: [[#{index},0],[#{index},#{compromisso.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end

  
end
