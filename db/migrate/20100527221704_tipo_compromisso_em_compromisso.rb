class TipoCompromissoEmCompromisso < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:tipo_compromisso_id,:integer
  end

  def self.down
    remove_column :compromissos,:tipo_compromisso_id
  end
end
