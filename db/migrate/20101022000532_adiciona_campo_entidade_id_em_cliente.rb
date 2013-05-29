class AdicionaCampoEntidadeIdEmCliente < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:entidade_id,:integer
  end

  def self.down
    remove_column :pessoas,:entidade_id
  end
end
