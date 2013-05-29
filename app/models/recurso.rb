class Recurso < ActiveRecord::Base

  validates_presence_of :nome,:descricao,:message=>"deve ser preenchido"
  has_many :retiradas
  belongs_to :entidade

    HUMANIZED_ATTRIBUTES = {
   :nome=>"O campo nome",
   :descricao=>"O campo descrição"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end
