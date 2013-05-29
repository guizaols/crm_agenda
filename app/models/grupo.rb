class Grupo < ActiveRecord::Base


  validates_presence_of :nome,:descricao
  has_many :pessoas

  HUMANIZED_ATTRIBUTES = {
    :nome => 'O campo Nome',
    :descricao => 'O campo Descrição',
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def self.retorna_grupos_para_select
    Grupo.all.collect{|p| [p.nome,p.id]}
  end

end
