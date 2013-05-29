class AdicionaCampoDataVenda < ActiveRecord::Migration
  def self.up
    add_column :propostas,:data_venda,:date
  end

  def self.down
    remove_column :propostas,:data_venda
  end
end
