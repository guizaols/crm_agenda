class CreateHistoricoClientes < ActiveRecord::Migration
  def self.up
    create_table :historico_clientes do |t|
      t.string :nome
      t.date :data
      t.text :descricao
      t.integer :pessoa_id
      t.integer :usuario_id
      t.timestamps
    end
  end

  def self.down
    drop_table :historico_clientes
  end
end
