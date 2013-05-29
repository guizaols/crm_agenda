class CreateRetiradas < ActiveRecord::Migration
  def self.up
    create_table :retiradas do |t|
      t.string :nome
      t.integer :usuario_id
      t.date :data_retirada
      t.date :data_entrega

      t.timestamps
    end
  end

  def self.down
    drop_table :retiradas
  end
end
