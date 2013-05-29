class AdicionaCampoCifrao < ActiveRecord::Migration
  def self.up
    add_column :moedas,:unidade,:string
  end

  def self.down
    remove_column :moedas,:unidade
  end
end
