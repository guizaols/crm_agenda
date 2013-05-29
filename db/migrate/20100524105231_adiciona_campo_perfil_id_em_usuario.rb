class AdicionaCampoPerfilIdEmUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios,:perfil_id,:integer
  end

  def self.down
    remove_column :usuarios,:perfil_id
  end
end
