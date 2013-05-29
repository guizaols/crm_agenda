class AdicionaPreco < ActiveRecord::Migration
  def self.up
    add_column :produtos,:valor,:string
  end

  def self.down
    remove_column :produtos,:valor
  end
end
