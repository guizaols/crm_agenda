class HistoricoCliente < ActiveRecord::Base

  ABERTO = 34
  EM_ANDAMENTO = 125
  ATENDIDO = 23
  CORRESPONDIDO = 98

  belongs_to :proposta
  belongs_to :usuario
  belongs_to :pessoa

  validates_presence_of :usuario, :data, :pessoa, :status, :tipo_acao, :motivo, :objetivo, :atividades, :message => 'deve ser preenchido'

  data_br_field :data


  HUMANIZED_ATTRIBUTES = {
    :usuario => "O campo Usuário",
    :descricao => "O campo Outras informações",
    :data => "O campo Data",
    :pessoa => "O campo Cliente",
    :status => 'O campo Status',
    :motivo => 'O campo motivo',
    :objetivo => 'O campo Objetivo',
    :atividades => 'O campo O que foi feito?',
    :tipo_acao => 'O campo Tipo de Ação'
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def initialize(attributes = {})
    attributes['data'] ||= Date.today
    super
  end

  def status_verbose
    case status
    when ABERTO; 'ABERTO'
    when EM_ANDAMENTO; 'EM ANDAMENTO'
    when ATENDIDO; 'ATENDIDO'
    when CORRESPONDIDO; 'CORRESPONDIDO'
    when nil; 'SEM STATUS'
    end
  end

end
