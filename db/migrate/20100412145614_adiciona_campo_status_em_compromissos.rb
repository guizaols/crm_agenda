class AdicionaCampoStatusEmCompromissos < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:status,:integer
  end

  def self.down
    remove_column :compromissos,:status
  end
end
