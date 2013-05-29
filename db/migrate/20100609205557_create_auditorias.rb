class CreateAuditorias < ActiveRecord::Migration
  def self.up
    create_table :auditorias do |t|
      t.string :operacao
      t.integer :usuario_id
      t.integer :proposta_id
      t.integer :historico_id
      t.integer :cliente_id
      t.integer :pessoa_id
      t.date :data
      t.timestamps
    end
  end

  def self.down
    drop_table :auditorias
  end
end
