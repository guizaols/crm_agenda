class AdicionaResponsavelEmCompromisso < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:usuario_id,:integer
  end

  def self.down
    remove_column :compromissos,:usuario_id
  end
end
