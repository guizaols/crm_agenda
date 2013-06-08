class CreateParentescos < ActiveRecord::Migration
  def self.up
    create_table :parentescos do |t|
      t.string :nome
      t.string :idade
      t.date :data_nascimento
      t.integer :pessoa_id
      t.integer :usuario_id
      t.string :tipo_parentesco

      t.timestamps
    end
  end

  def self.down
    drop_table :parentescos
  end
end
