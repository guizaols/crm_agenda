class CreateSuportes < ActiveRecord::Migration
  def self.up
    create_table :suportes do |t|
      t.integer :proposta_id
      t.date :data
      t.integer :prioridade
      t.integer :status
      t.integer :usuario_id
      t.timestamps
    end
  end

  def self.down
    drop_table :suportes
  end
end
