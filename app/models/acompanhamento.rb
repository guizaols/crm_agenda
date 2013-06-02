class Acompanhamento < ActiveRecord::Base

  VENDIDO = 1
  NAO_VENDIDO = 0
  validates_presence_of :nome,:descricao,:message=>"deve ser preenchido"
  validates_inclusion_of :vendido,:in=>[VENDIDO,NAO_VENDIDO],:message=>"não está incluído na lista"
  has_many :propostas

    HUMANIZED_ATTRIBUTES = {
   :nome=>"O campo nome",
   :descricao=>"O campo descrição",
   :vendido=>"O campo vendido"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def validate
    errors.add :base,"Existe outro registro indicando venda" if tem_status_vendido?
  end

  def tem_status_vendido?

    tipo = Acompanhamento.find(:all,:conditions=>["vendido = 1"]).first rescue nil
    retorno = true
    if !tipo.blank?
      if tipo.id == self.id
        return false
      else
        return true
      end
    else
      return false
    end
    retorno
  end


  def vendido_verbose?
    if vendido == 1
      "Sim"
    else
      "Não"
    end
  end
end
