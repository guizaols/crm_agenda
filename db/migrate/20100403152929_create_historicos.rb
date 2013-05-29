class CreateHistoricos < ActiveRecord::Migration
  def self.up
    create_table :historicos do |t|
      t.integer :usuario_id
      t.text :descricao
      t.integer :pessoa_id
      t.date :data
      t.integer :proposta_id

      t.timestamps
    end
  end

  def self.down
    drop_table :historicos
  end
end
