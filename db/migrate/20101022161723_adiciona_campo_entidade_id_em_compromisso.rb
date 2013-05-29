class AdicionaCampoEntidadeIdEmCompromisso < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:entidade_id,:integer
  end

  def self.down
    remove_column :compromissos,:entidade_id
  end
end
