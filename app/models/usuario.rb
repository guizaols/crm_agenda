require 'digest/sha1'

class Usuario < ActiveRecord::Base
  #  exibir_no_sitemap
  #  exibir_no_sitemap do |obj|
  #    out = []
  #    obj.globalize_translations.each do |translation|
  #      out << ["secao_#{translation.locale}_url".to_sym, translation.identificacao, translation.updated_at]
  #    end
  #    out
  #  end

  ADMINISTRADOR_CONCESSIONARIA = 1
  VENDEDOR = 2
  PEUGEOT = 3
  RECEPCIONISTA = 4
  TELEMARKETING = 5

  @@humanized_attributes = {
    :name => 'Nome',
    :password => 'Senha',
    :password_confirmation => 'Confirmação da Senha',
  }

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :name
  validates_length_of       :login,    :within => 3..40, :message => 'deve possuir ao menos 3 caracteres'
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100, :message => 'deve possuir no máximo 100 caracteres'

  validates_length_of       :email,    :within => 6..100, :message => 'deve possuir ao menos 6 caracteres'
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  has_many :compromissos
  has_many :propostas
  has_many :historicos
  has_many :historico_clientes
  has_many :suportes
  has_many :retiradas
  belongs_to :entidade
   has_many :compromissos, :foreign_key => 'agendado_por'
  has_and_belongs_to_many :pessoas

  attr_accessible :login, :email, :name,:cargo, :password, :password_confirmation,:perfil_id,:entidade_id

  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected

end
