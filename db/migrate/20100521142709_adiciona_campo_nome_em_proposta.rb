class AdicionaCampoNomeEmProposta < ActiveRecord::Migration
  def self.up
    add_column :propostas,:nome,:string
  end

  def self.down
    remove_column :propostas,:nome
  end
end
