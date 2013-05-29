class Auditoria < ActiveRecord::Base
  data_br_field :data
  belongs_to :usuario
  belongs_to :proposta
  belongs_to :historico
  belongs_to :pessoa
  belongs_to :entidade

  def self.procura_operacoes(params,usuario)
    params = params.dup
    if usuario.perfil_id == 3
      if params["entidade_id"].blank?

      Auditoria.all(:conditions=>["data >= ? AND data <= ?",params["data_inicial"].to_date,params["data_final"].to_date],:order=>["data DESC"]).group_by(&:entidade)
      else
        Auditoria.all(:conditions=>["data >= ? AND data <= ? AND entidade_id = ?",params["data_inicial"].to_date,params["data_final"].to_date,params["entidade_id"]],:order=>["data DESC"]).group_by(&:entidade)
      end
    else
      Auditoria.all(:conditions=>["data >= ? AND data <= ? AND entidade_id = ?",params["data_inicial"].to_date,params["data_final"].to_date,usuario.entidade_id],:order=>["data DESC"]).group_by(&:usuario)
    end
  end

end
