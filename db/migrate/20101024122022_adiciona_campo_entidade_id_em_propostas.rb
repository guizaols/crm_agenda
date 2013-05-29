class AdicionaCampoEntidadeIdEmPropostas < ActiveRecord::Migration
  def self.up
    add_column :propostas,:entidade_id,:integer
  end

  def self.down
    remove_column :propostas,:entidade_id
  end
end
