class CreateMoedas < ActiveRecord::Migration
  def self.up
    create_table :moedas do |t|
      t.string :nome
      t.float :valor

      t.timestamps
    end
  end

  def self.down
    drop_table :moedas
  end
end
