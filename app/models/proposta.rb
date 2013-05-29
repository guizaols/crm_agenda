class Proposta < ActiveRecord::Base

  validates_presence_of :produto,:usuario,:pessoa,:status,:message=>"deve ser preenchido"
  validates_presence_of :acompanhamento,:message=>"deve ser preenchido"
  belongs_to :usuario
  belongs_to :pessoa
  belongs_to :produto
  belongs_to :moeda
  belongs_to :entidade
  has_many :historicos,:dependent => :destroy
  has_many :suportes
  belongs_to :acompanhamento
  data_br_field :data_inicio,:data_venda
  attr_accessor :valor_virtual
  usar_como_dinheiro :valor_entrada,:valor,:valor_financiado,:avaliacao_usado
  

  HUMANIZED_ATTRIBUTES = {
    :produto=>"O campo Produto",
    :usuario=>"O campo Consultor Comercial",
    :pessoa=>"O campo Cliente",
    :status=>"O campo Status",
    :acompanhamento => "O campo Status"
  }

  SITUACAO = {1=>"10% e 20%", 2=>"50%",3=>"75%",4=>"90%",5=>"100%",6=>"0%"}
  SITUACAO_VERBOSE = {1=>"Entre 10 e 20 %", 2=>"Em 50%",3=>"Em 75%",4=>"Em 90%",5=>"Em 100%",6=>"Em 0%"}
  

  def initialize(attributes = {})
    attributes['status'] ||= 1
    attributes['quantidade'] ||= 1
    attributes['valor'] ||= "0.00"
    attributes['avaliacao_usado'] ||= "0.00"
    attributes['valor_entrada'] ||= "0.00"
    attributes['valor_financiado'] ||= "Pressione o Link para Calcular Financiamento"
    attributes['data_inicio'] ||= Date.today
    super
  end

  def before_save
    #    unless self.moeda.blank?
    #      self.valor_da_moeda = self.moeda.valor if self.new_record?
    #      self.valor = @valor_virtual.to_f * self.valor_da_moeda.to_f
    #    else
    #      self.valor = @valor_virtual.to_f
    #    end
    # self.valor = @valor_virtual
  end

  def before_validation
    self.nome = self.produto.nome unless self.produto.blank?
  end


  def self.calcula_financiamento(valor_produto,quantidade,valor_entrada,valor_seminovo)
    valor_financiamento = (valor_produto*quantidade)-(valor_seminovo + valor_entrada)
    @aux = Proposta.new
    @aux.valor = valor_financiamento
    valor_financiamento = @aux.valor.reais_contabeis.gsub("RS ","")
    return valor_financiamento

  end

  def valor_do_financiamento_eh_invalido
    if self.existe_usado && self.veiculo_financiado
      soma = self.valor.real.quantia - (self.avaliacao_usado.real.quantia + self.valor_entrada.real.quantia)
      if soma < 0
        true
      else
        false
      end
    else
      false
    end
  end


  
  def valor_virtual
    "#{self.valor.to_s}"
  end

  def mostra_valor_em_reais
    unless self.moeda.blank?
      unless self.valor_da_moeda.blank?
        self.valor.to_f / (self.valor_da_moeda.to_f.blank?) rescue "erro!"
      else
        self.valor.to_f / self.moeda.valor.to_f
      end
    else
      self.valor.to_f
    end
  end


  def converte_valor
    self.valor.to_s.gsub(/[,\.]/, "").to_f/100
  end

  def converte_valor_entrada
    self.valor_entrada.to_s.gsub(/[,\.]/, "").to_f/100
  end
  

  def valor_virtual
    if !self.moeda.blank?
      self.valor.to_f / self.valor_da_moeda.to_f rescue "erro!"
    else
      self.valor.to_f
    end
  end
  

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def status_verbose
    SITUACAO[self.status]
  end

  def dados_do_financiamento_nao_estao_preenchidos
    ret = false
    if self.veiculo_financiado
      ret = true if self.financiamento_numero_parcelas.blank? && self.financiamento_valor_parcelas.blank?
    end
    ret
  end

  def dados_do_usado_nao_estao_preenchidos
    ret = false
    if self.veiculo_financiado
      ret = true if self.usado.blank? && self.avaliacao_usado.blank?
    end
    ret
  end

  def validate
    errors.add :base, "Preencher os campos referente ao financiamento" if dados_do_financiamento_nao_estao_preenchidos
    errors.add :base, "Preencher os campos referente ao veículo usado" if dados_do_usado_nao_estao_preenchidos
    errors.add :base, "Valor do Financiamento é inválido" if valor_do_financiamento_eh_invalido
    errors.add :base, "Os dados do cliente #{self.pessoa.tipo_pessoa == Pessoa::FISICA ? self.pessoa.nome : self.pessoa.razao_social} não estão preenchidos completamente" if !self.pessoa.dados_estao_completos?
  end

  def self.procura_propostas(params,usuario)
    params = params.dup
    data_inicial = params["data_inicial"]
    data_final = params["data_final"]
    if params["data_inicial"].blank?
      data_inicial = Date.today.to_s_br
    end
    if params["data_final"].blank?
      data_final = Date.today.to_s_br
    end
    if usuario.perfil_id != 3
      Proposta.find(:all,:include=>[:pessoa],:conditions=>["data_venda>= ? and data_venda <= ? and pessoas.entidade_id = ?",data_inicial.to_date,data_final.to_date,usuario.entidade_id])
    else
      if params["entidade_id"].blank?
        Proposta.find(:all,:conditions=>["data_venda>= ? and data_venda <= ?",data_inicial.to_date,data_final.to_date])
      else
        Proposta.find(:all,:include=>[:pessoa],:conditions=>["data_venda>= ? and data_venda <= ? and pessoas.entidade_id = ?",data_inicial.to_date,data_final.to_date,params["entidade_id"]])
      end
    end

  end


  def self.procura_propostas_por_funcionario(params)
    params = params.dup
    data_inicial = params["data_inicial"]
    data_final = params["data_final"]
    if params["data_inicial"].blank?
      data_inicial = Date.today.to_s_br
    end
    if params["data_final"].blank?
      data_final = Date.today.to_s_br
    end
    Proposta.find(:all,:conditions=>["data_venda>= ? and data_venda <= ?",data_inicial.to_date,data_final.to_date]).group_by(&:usuario)
  end



  def self.retorna_propostas_para_grafico(usuario)
    retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i = 0
    data_inicio = Date.new(Date.today.year,Date.today.month,1)
    data_final = (Date.new(Date.today.year,Date.today.month,31) rescue (Date.new(Date.today.year,Date.today.month,30)))

    if usuario.perfil_id ==3
   
      propostas = Proposta.find(:all,:conditions=>["data_venda >= ? and data_venda <= ?",data_inicio,data_final]).group_by(&:entidade)
    else
      propostas = Proposta.find(:all,:include=>[:usuario],:conditions=>["data_venda >= ? and data_venda <= ? and usuarios.entidade_id =?",data_inicio,data_final,usuario.entidade_id]).group_by(&:usuario)
    end

    propostas.each_with_index do |proposta,index|

      if usuario.perfil_id !=3
        dados_eixo_x << "[#{index}.5,'#{((Usuario.find proposta.first).name)}' ]"
      else
        dados_eixo_x << "[#{index}.5,'#{proposta.first.nome}' ]"
      end

      dados_eixo_y << "{data: [[#{index},0],[#{index},#{proposta.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end

  def self.grafico_vendas(status)
    status = status.dup
    retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i = 0
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

    propostas = Proposta.find(:all,:conditions=>["data_venda >= ? and data_venda <= ?",data_inicio,data_final]).group_by(&:usuario)
    propostas.each_with_index do |proposta,index|
      dados_eixo_x << "[#{index}.5,'#{(Usuario.find proposta.first).name}' ]"
      dados_eixo_y << "{data: [[#{index},0],[#{index},#{proposta.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end


  def self.grafico_vendas_status(status)
    status = status.dup
    retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i = 0
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



    propostas = Proposta.find(:all,:conditions=>["data_inicio >= ? and data_inicio <= ?",data_inicio,data_final]).group_by(&:status)
    propostas.each_with_index do |proposta,index|
      dados_eixo_x << "[#{index}.5,'#{(SITUACAO[proposta.first])}' ]"
      dados_eixo_y << "{data: [[#{index},0],[#{index},#{proposta.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end

  def self.retorna_propostas_para_grafico_por_situacao_mes(usuario)
    dados = []
    data_inicio = Date.new(Date.today.year,Date.today.month,1)
    data_final = (Date.new(Date.today.year,Date.today.month,31) rescue (Date.new(Date.today.year,Date.today.month,30)))
    
    if usuario.perfil_id == 3
      sql = Proposta.find(:all,:conditions=>["data_inicio >= ? and data_inicio <= ?",data_inicio,data_final]).group_by(&:acompanhamento)
    else
      sql = Proposta.find(:all,:include=>[:usuario],:conditions=>["usuarios.entidade_id =? and data_inicio >= ? and data_inicio <= ?",usuario.entidade_id,data_inicio,data_final]).group_by(&:acompanhamento)
    end

    sql.each do |proposta|
      dados <<  "{ label: '#{(proposta.first.nome rescue nil)}',  data: #{proposta.last.length} }"
    end
    dados
  end

  def self.retorna_propostas_para_grafico_por_situacao(usuario)
    dados = []
    
    
    if usuario.perfil_id == 3
      sql = Proposta.find(:all).group_by(&:acompanhamento)
    else
      sql = Proposta.find(:all,:include=>[:usuario],:conditions=>["usuarios.entidade_id = ?",usuario.entidade_id]).group_by(&:acompanhamento)
    end


    sql.each do |proposta|
      
      dados <<  "{ label: '#{(proposta.first.nome rescue nil)}',  data: #{proposta.last.length} }"
    end
    dados
  end

  def self.retorna_propostas_para_grafico_por_situacao_barras(usuario)
    retorno = {}
    dados_eixo_x = []
    dados_eixo_y = []
    i = 0
    data_inicio = Date.new(Date.today.year,Date.today.month,1)
    data_final = (Date.new(Date.today.year,Date.today.month,31) rescue (Date.new(Date.today.year,Date.today.month,30)))

    if usuario.perfil_id == 3
      propostas = Proposta.find(:all,:conditions=>["data_inicio >= ? and data_inicio <= ?",data_inicio,data_final]).group_by(&:acompanhamento)
    else
      propostas = Proposta.find(:all,:include=>[:usuario],:conditions=>["data_inicio >= ? and data_inicio <= ? and usuarios.entidade_id = ?",data_inicio,data_final,usuario.entidade_id]).group_by(&:acompanhamento)
      
    end



    propostas.each_with_index do |proposta,index|
      dados_eixo_x << "[#{index}.5,'#{(proposta.first.nome rescue nil)}' ]"
      dados_eixo_y << "{data: [[#{index},0],[#{index},#{proposta.last.length}]] ,bars:{show:true}}"
      i+=1
    end
    retorno["eixo_x"] ||= dados_eixo_x
    retorno["eixo_y"] ||= dados_eixo_y
    retorno["maximo"] ||= i
    retorno
  end



end
