class AdicionaCorEmTipoDeCompromisso < ActiveRecord::Migration
  def self.up
    add_column :tipo_compromissos,:color,:string
  end

  def self.down
    remove_column :tipo_compromissos,:color
  end
end
