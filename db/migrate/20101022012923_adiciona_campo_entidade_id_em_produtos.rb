class AdicionaCampoEntidadeIdEmProdutos < ActiveRecord::Migration
  def self.up
    add_column :produtos,:entidade_id,:integer
  end

  def self.down
    remove_column :produtos,:entidade_id
  end
end
