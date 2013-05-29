class AdicionaCampoHorasNasRetiradas < ActiveRecord::Migration
  def self.up
    add_column :retiradas,:hora_inicial,:string
    add_column :retiradas,:final,:string
  end

  def self.down
    remove_column :retiradas,:hora_inicial
    remove_column :retiradas,:final
  end
end
