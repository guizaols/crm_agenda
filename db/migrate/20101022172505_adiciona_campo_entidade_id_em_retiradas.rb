class AdicionaCampoEntidadeIdEmRetiradas < ActiveRecord::Migration
  def self.up
    add_column :retiradas,:entidade_id,:integer
  end

  def self.down
    remove_column :retiradas,:entidade_id,:integer
  end
end
