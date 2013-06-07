class HistoricoCliente < ActiveRecord::Base

  validates_presence_of :usuario, :descricao, :data, :pessoa, :message => 'deve ser preenchido'
  belongs_to :proposta
  belongs_to :usuario
  belongs_to :pessoa
  data_br_field :data


  HUMANIZED_ATTRIBUTES = {
    :usuario => "O campo Usuário",
    :descricao => "O campo Descrição",
    :data => "O campo Data",
    :pessoa => "O campo Cliente",
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def initialize(attributes = {})
    attributes['data'] ||= Date.today
    super
  end

end
