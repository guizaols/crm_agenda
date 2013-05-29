class Retirada < ActiveRecord::Base

  validates_presence_of :usuario,:justificativa,:data_retirada,:data_entrega,:recurso,:message=>"deve ser preenchido"
  belongs_to :usuario
  belongs_to :recurso
  data_br_field :data_retirada
  data_br_field :data_entrega
  belongs_to :entidade

  HUMANIZED_ATTRIBUTES = {
    :nome=>"O campo nome",
    :usuario=>"O campo usuário",
    :data_retirada=>"O campo data de retirada",
    :data_entrega=>"O campo data de entrega",
    :recurso=>"O campo recurso",
    :justificativa=>"O campo justificativa"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def validate
    errors.add :base, "A data de retirada deve ser menor do que a data de entrega" if datas_invalidas?
    errors.add :base, "Este recurso já está ocupado para esta data" if equipamento_ocupado? && self.data_retirada_changed? && self.data_entrega_changed?
  end

  def datas_invalidas?
    if !self.data_retirada.blank? && !self.data_entrega.blank?
      if  self.data_entrega.to_date < self.data_retirada.to_date
        return true
      else
        return false
      end
    else
      return true
    end
  end


  def equipamento_ocupado?
    erro = 0
    if !self.data_retirada.blank? && !self.data_entrega.blank? && !self.recurso.blank? && !self.hora_inicial.blank? && !self.final.blank?
      data_hora_retirada = DateTime.strptime("#{self.data_retirada.to_date.strftime("%Y/%m/%d")} #{self.hora_inicial}:00", "%Y/%m/%d %H:%M:%S") rescue nil
      data_hora_devolucao = DateTime.strptime("#{self.data_entrega.to_date.strftime("%Y/%m/%d")} #{self.final}:00", "%Y/%m/%d %H:%M:%S") rescue nil
      solicitacoes = Retirada.all(:conditions=>["data_retirada = ? AND recurso_id = ?",self.data_retirada.to_date,self.recurso_id])
      solicitacoes.each do |solicitacao|
        if( (DateTime.strptime("#{solicitacao.data_retirada.to_date.strftime("%Y/%m/%d")} #{solicitacao.hora_inicial}:00", "%Y/%m/%d %H:%M:%S") >= data_hora_retirada) && (DateTime.strptime("#{solicitacao.data_entrega.to_date.strftime("%Y/%m/%d")} #{solicitacao.final}:00", "%Y/%m/%d %H:%M:%S") <= data_hora_devolucao )) ||
          (data_hora_retirada >= DateTime.strptime("#{solicitacao.data_retirada.to_date.strftime("%Y/%m/%d")} #{solicitacao.hora_inicial}:00", "%Y/%m/%d %H:%M:%S") && data_hora_devolucao <= DateTime.strptime("#{solicitacao.data_entrega.to_date.strftime("%Y/%m/%d")} #{solicitacao.final}:00", "%Y/%m/%d %H:%M:%S"))||
          (data_hora_retirada >= DateTime.strptime("#{solicitacao.data_retirada.to_date.strftime("%Y/%m/%d")} #{solicitacao.hora_inicial}:00", "%Y/%m/%d %H:%M:%S") && data_hora_retirada <= DateTime.strptime("#{solicitacao.data_entrega.to_date.strftime("%Y/%m/%d")} #{solicitacao.final}:00", "%Y/%m/%d %H:%M:%S"))

          erro +=1
        end
      end
    else
      erro +=1
    end
    if erro > 0
      return true
    else
      return false
    end
  end

  def self.busca_retirada(usuario,params)
    sqls = []
    parametros = []
    if !params["usuario_id"].blank?
      sqls << "usuario_id = ?"
      parametros << "#{params["usuario_id"]}"
    end
    unless params["data_retirada"].blank?
      sqls << "data_retirada = ?"
      parametros << "#{params["data_retirada"].to_date}"
    end
    if usuario.perfil_id != 3
      sqls << "entidade_id = ?"
      parametros << "#{usuario.entidade_id}"
    end
    @retiradas = Retirada.all(:conditions=> [sqls.join(" AND ")] + parametros,:order=>"data_retirada DESC")
  end

  
end
