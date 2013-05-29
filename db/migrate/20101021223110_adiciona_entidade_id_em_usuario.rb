class AdicionaEntidadeIdEmUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios,:entidade_id,:integer
  end

  def self.down
    remove_column :usuarios,:entidade_id
  end
end
