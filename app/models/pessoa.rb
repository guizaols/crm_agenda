class Pessoa < ActiveRecord::Base

  #CONSTANTES
  FISICA = 1
  JURIDICA = 2

#  validates_presence_of :nome, :telefone,:endereco,:bairro,:numero, :message =>"deve ser preenchido"
 # validates_presence_of :razao_socisal, :message => 'deve ser preenchido', :if => :juridica?
  validates_inclusion_of :tipo_pessoa, :in => [FISICA, JURIDICA],:message =>"deve ser selecionado"
  validates_presence_of :nome,:telefone,:origem, :message => 'deve ser preenchido', :if => :fisica?
  validates_presence_of :razao_social,:telefone,:grupo,:origem, :message => 'deve ser preenchido', :if => :juridica?
  serialize :email
  serialize :telefone
  has_many :compromissos
  belongs_to :origem
  has_many :propostas
  has_many :historico_clientes
  has_and_belongs_to_many :usuarios
  belongs_to :grupo
  belongs_to :entidade



  HUMANIZED_ATTRIBUTES = {
    :cpf => 'O campo CPF',
    :cnpj=> 'O campo CNPJ',
    :numero=>'O campo número',
    :moeda => 'O campo moeda',
    :razao_social =>'O campo Razão Social',
    :nome =>'O campo Nome',
    :complemento=>'O campo Complemento',
    :contato =>'O campo Contato',
    :tipo_pessoa =>'O campo Tipo de pessoa',
    :endereco =>'O campo Endereço',
    :email =>'O campo E-mail',
    :telefone =>'O campo Telefone',
    :rg_ie =>'O campo RG/IE',
    :cep => 'O campo Cep',
    :origem => 'O campo Origem',
    :observacoes =>'O campo Observações',
    :bairro =>'O campo Bairro',
    :grupo=>"O campo Segmento"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def fisica?
    tipo_pessoa == FISICA
  end

  def juridica?
    tipo_pessoa == JURIDICA
  end

  def tipo_verbose
    fisica? ? 'Física' : 'Jurídica'
  end

  def telefone
    super || []
  end

  def initialize(attributes= {})
    super
  end

  def before_validation
    self.telefone.reject!(&:blank?)
    self.email.reject!(&:blank?)
  end

  def email
    super || []
  end
  def label_do_campo_cpf_cnpj
    case tipo_pessoa
    when JURIDICA;" CNPJ"
    when FISICA;"CPF"
    else "CPF/CNPJ"
    end
  end

  def label_do_campo_rg_ie
    case tipo_pessoa
    when JURIDICA;"IE"
    when FISICA;"RG"
    else "RG/IE"
    end
  end

  def label_nome_ou_nome_fantasia
    case tipo_pessoa
    when JURIDICA;" Nome Fantasia"
    when FISICA;" Nome*"
    else " Nome/Nome Fantasia"
    end
  end

  def retorna_tipo_pessoa
    tipo_pessoa == FISICA ? 'Pessoa física' : 'Pessoa Jurídica'
  end

  def self.buscar_clientes(params,usuario)
    parametros = params["parametro"].dup
    if usuario.perfil_id == 2
      Pessoa.find(:all,:include=>["usuarios"],:order=>["pessoas.nome ASC"],:conditions=>["(nome LIKE ? OR razao_social LIKE ? OR cpf LIKE ? OR cnpj LIKE ? OR pessoas.email LIKE ? OR contato LIKE ? OR telefone LIKE ?) AND usuarios.id = ?","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%",usuario.id])
    elsif usuario.perfil_id == 1
      if params["usuario_id"].blank?
        Pessoa.find(:all,:order=>["nome ASC"],:conditions=>["(nome LIKE ? OR razao_social LIKE ? OR cpf LIKE ? OR cnpj LIKE ? OR email LIKE ? OR contato LIKE ? or telefone like ?) AND entidade_id = ?","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%",usuario.entidade_id])
      else
        Pessoa.find(:all,:include=>["usuarios"],:order=>["nome ASC"],:conditions=>["(pessoas.nome LIKE ? OR razao_social LIKE ? OR cpf LIKE ? OR cnpj LIKE ? OR pessoas.email LIKE ? OR contato LIKE ? OR telefone like ?) AND usuarios.id = ?","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%",params["usuario_id"]])
      end
    else
      if !params["usuario_id"].blank?
        Pessoa.find(:all,:order=>["nome ASC"],:conditions=>["(nome LIKE ? OR razao_social LIKE ? OR cpf LIKE ? OR cnpj LIKE ? OR email LIKE ? OR contato LIKE ? OR telefone LIKE ?) AND entidade_id = ?","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%",params["usuario_id"]])
      else
        Pessoa.find(:all,:include=>["usuarios"],:order=>["nome ASC"],:conditions=>["(pessoas.nome LIKE ? OR razao_social LIKE ? OR cpf LIKE ? OR cnpj LIKE ? OR pessoas.email LIKE ? OR contato LIKE ? OR telefone LIKE ?)","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%","%#{parametros}%"])
      end
    end
  end



  def self.buscar_clientes_para_peugeot(params)
    parametros = params.dup
    if parametros["entidade_id"].blank?
      Pessoa.find(:all,:order=>["nome ASC"] )
    else
      Pessoa.find(:all,:conditions=>["entidade_id = ?",parametros["entidade_id"]],:order=>["nome ASC"] )

    end
  end

  def ultimo_contato
    ultimo = Compromisso.all(:conditions=>["pessoa_id = ? ",self.id],:order=>["data ASC"])
    if ultimo.blank?
      return "Sem Compromisso"
    else
      ultimo.each do |u|
        if u.data.to_date == Date.today
          return "COMPROMISSO HOJE"
        end
      end
      ultimo = ultimo.first
      data_segundos = (Date.today - ultimo.data.to_date).days
      if data_segundos > 0
        "#{(data_segundos.to_i)/86400} dias atrás"
      else
        "Próximo contato será em #{((data_segundos.to_i)/86400) * (-1)} dias"
      end
    end
  end

  def ultimo_contato_em_numeros
    ultimo = Compromisso.all(:conditions=>["pessoa_id = ? ",self.id],:order=>["data DESC"])
    if ultimo.blank?
      return 0
    else
      ultimo.each do |u|
        if u.data.to_date == Date.today
          return 0
        end
      end
      ultimo = ultimo.first
      data_segundos = (Date.today - ultimo.data.to_date).days
      if data_segundos > 0
        data_segundos.to_i/86400
      else
        ((data_segundos.to_i)/86400)
      end
    end
  end

  def compromissos_hoje
    Compromisso.all(:conditions=>["data = ? AND pessoa_id= ?",Date.today,self.id]) rescue nil
  end

  def numero_de_propostas
    Proposta.all(:conditions=>["status = 2 and pessoa_id = ?",self.id]).length
  end

  def dados_estao_completos?
    r = true
    if self.tipo_pessoa == FISICA
        return false if self.cpf.blank? || self.cidade.blank? || self.bairro.blank? || self.endereco.blank?
    else
        return false if self.cnpj.blank? || self.cidade.blank? || self.bairro.blank? || self.endereco.blank?
    end
    r
  end


end
