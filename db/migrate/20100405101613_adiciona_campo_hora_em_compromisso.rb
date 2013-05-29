class AdicionaCampoHoraEmCompromisso < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:hora,:string
  end

  def self.down
    remove_column :compromissos,:hora
  end
end
