class AdicionaCampoEmCompromissos < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:agendado_por,:integer
  end

  def self.down
  end
end
