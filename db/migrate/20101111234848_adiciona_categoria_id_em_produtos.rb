class AdicionaCategoriaIdEmProdutos < ActiveRecord::Migration
  def self.up
    add_column :produtos,:categoria_id,:integer
  end

  def self.down
  end
end
