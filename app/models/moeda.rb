class Moeda < ActiveRecord::Base

  validates_presence_of :nome,:unidade,:valor,:message=>"deve ser preenchido"
  has_many :pessoas

    HUMANIZED_ATTRIBUTES = {
   :nome=>"O campo nome",
   :unidade=>"O campo unidade",
   :valor=>"O campo valor"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


end
