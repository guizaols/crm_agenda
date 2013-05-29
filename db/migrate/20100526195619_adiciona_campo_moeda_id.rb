class AdicionaCampoMoedaId < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:moeda_id,:integer
  end

  def self.down
    remove_column :pessoas,:moeda_id
  end
end
