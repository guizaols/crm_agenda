class AdicionaCamposEmProdutos < ActiveRecord::Migration
  def self.up
    add_column :produtos,:acessorios,:text
    add_column :produtos,:opcionais,:text
  end

  def self.down
  end
end
