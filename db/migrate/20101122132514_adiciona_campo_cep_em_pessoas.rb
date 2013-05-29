class AdicionaCampoCepEmPessoas < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:cep,:integer
  end

  def self.down
    remove_column :pessoas,:cep
  end
end
