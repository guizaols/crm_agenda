class Parentesco < ActiveRecord::Base

  validates_presence_of :usuario, :pessoa, :nome, :tipo_parentesco, :message => 'deve ser preenchido'
  belongs_to :usuario
  belongs_to :pessoa
  has_many :propostas
  data_br_field :data_nascimento


  HUMANIZED_ATTRIBUTES = {
    :usuario => 'O campo Usuário',
    :pessoa => 'O campo Cliente',
    :nome => 'O campo Nome',
    :data_nascimento => 'O campo Data de Nascimento',
    :idade => 'O campo idade',
    :tipo_parentesco => 'O campo tipo de parentesco'
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end
