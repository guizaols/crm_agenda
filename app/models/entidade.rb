class Entidade < ActiveRecord::Base



  validates_presence_of :nome,:nome_responsavel, :telefone_responsavel,:email_responsavel, :message =>"deve ser preenchido"
  serialize :email_responsavel
  serialize :telefone_responsavel
  has_many :usuarios
  has_many :pessoas
  has_many :retiradas
  has_many :produtos
  has_many :recursos
  has_many :auditorias
  has_many :compromissos
  has_many :propostas

  
  HUMANIZED_ATTRIBUTES = {
    :nome => "O campo nome",
    :nome_reponsavel => "O campo Proprietário",
    :telefone_responsavel => "O campo Telefone",
    :email_responsavel => "O campo Email",
    :cidade => "O campo Cidade",
    :bairro => "O campo Bairro",
    :endereco => "O campo Endereço",
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def before_validation
    self.telefone_responsavel.reject!(&:blank?)
    self.email_responsavel.reject!(&:blank?)
  end

  def email_responsavel
    super || []
  end

  def telefone_responsavel
    super || []
  end

end
