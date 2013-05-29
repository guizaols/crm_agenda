class CreateCompromissos < ActiveRecord::Migration
  def self.up
    create_table :compromissos do |t|
      t.string :nome
      t.date :data
      t.text :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :compromissos
  end
end
