class Produto < ActiveRecord::Base


  validates_presence_of :nome,:descricao,:categoria
  has_many :propostas
  belongs_to :entidade
  belongs_to :categoria
  attr_accessor :valor_virtual
 

  HUMANIZED_ATTRIBUTES = {
    :nome => 'O campo Nome',
    :descricao => 'O campo Descrição',
    :categoria => "O campo Categoria",
    :acessorios => "O campo acessóarios",
    :adicionais => "O campo adicionais",
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  def initialize(attributes = {})
    attributes['valor'] ||= "0.00"
    super
  end


  def before_save
    self.valor = @valor_virtual
  end

  def valor_virtual
    self.valor
  end

  def self.retorna_produtos_para_select(entidade_id)
    Produto.all(:conditions=>["entidade_id = ?",entidade_id]).collect{|p| [p.nome,p.id]}
  end



end
