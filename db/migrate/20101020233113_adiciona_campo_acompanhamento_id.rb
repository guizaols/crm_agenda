class AdicionaCampoAcompanhamentoId < ActiveRecord::Migration
  def self.up
    add_column :propostas,:acompanhamento_id,:integer
  end

  def self.down
    remove_column :propostas,:acompanhamento_id
  end
end
