class CreateClientesUsuarios < ActiveRecord::Migration
  def self.up
    create_table :pessoas_usuarios,:id=>false do |t|
      t.references :usuario,:pessoa
    end
  end

  def self.down
    drop_table :pessoas_usuarios
  end
end
