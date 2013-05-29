class CreateAcompanhamentos < ActiveRecord::Migration
  def self.up
    create_table :acompanhamentos do |t|
      t.string :nome
      t.integer :vendido
      t.text :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :acompanhamentos
  end
end
