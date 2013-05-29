class AdicionaCampoCotacaoEmProposta < ActiveRecord::Migration
  def self.up
    add_column :propostas,:valor_da_moeda,:float
  end

  def self.down
    remove_column :propostas,:valor_da_moeda
  end
end
