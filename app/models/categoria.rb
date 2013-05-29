class Categoria < ActiveRecord::Base

  has_many :produtos
  validates_presence_of :nome,:descricao



   HUMANIZED_ATTRIBUTES = {
    :nome => 'O campo Nome',
    :descricao => 'O campo Descrição',
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  def self.retorna_categorias_para_select
    Categoria.all.collect{|p| [p.nome,p.id]}
  end

end
