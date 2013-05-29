class AdicionaCampoDescricaoEmPropostas < ActiveRecord::Migration
  def self.up
    add_column :propostas,:descricao,:text
  end

  def self.down
    remove_column :propostas,:descricao
  end
end
