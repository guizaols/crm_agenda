class Origem < ActiveRecord::Base



  validates_presence_of :nome,:descricao
  has_many :pessoas
  
 HUMANIZED_ATTRIBUTES = {
    :nome => 'O campo Nome',
    :descricao => 'O campo Descrição',
    :acessorios => "O campo acessóarios",
    :adicionais => "O campo adicionais",
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  def initialize(attributes = {})
    super
  end

  def self.retorna_origem_para_select
    Origem.all.collect{|p| [p.nome,p.id]}
  end


end
