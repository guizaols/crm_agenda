class AdicionaPropostaEnviadaEmSuportes < ActiveRecord::Migration
  def self.up
    add_column :suportes,:proposta_enviada,:boolean
  end

  def self.down
    remove_column :suportes,:proposta_enviada
  end
end
