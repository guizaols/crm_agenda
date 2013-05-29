class AdicionaCampoDeEscopoEmPropostas < ActiveRecord::Migration
  def self.up
    add_column :propostas,:escopo,:text
    add_column :propostas,:premissas,:text
    add_column :propostas,:escopo_negativo,:text
  end

  def self.down
  end
end
