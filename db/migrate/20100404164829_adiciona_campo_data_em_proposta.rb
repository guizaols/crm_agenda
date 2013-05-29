class AdicionaCampoDataEmProposta < ActiveRecord::Migration
  def self.up
    add_column :propostas,:data_inicio,:date
  end

  def self.down
    remove_column :propostas,:data_inicio
  end
end
