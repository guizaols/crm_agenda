class AdicionaCampoMoedaEmProposta < ActiveRecord::Migration
  def self.up
    add_column :propostas,:moeda_id,:integer
  end

  def self.down
    remove_column :propostas,:moeda_id
  end
end
