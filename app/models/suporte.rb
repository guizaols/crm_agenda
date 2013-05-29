class Suporte < ActiveRecord::Base


  STATUS = {0=>"Solicitada",1=>"Concluída"}
  PRIORIDADE = {0=>"Baixa",1=>"Média",2=>"Urgente"}

  belongs_to :proposta
  belongs_to :usuario
  data_br_field :data

  def status_verbose
    STATUS[self.status]
  end
  

end
