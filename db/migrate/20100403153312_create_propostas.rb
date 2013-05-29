class CreatePropostas < ActiveRecord::Migration
  def self.up
    create_table :propostas do |t|
      t.integer :pessoa_id
      t.integer :produto_id
      t.integer :status
      t.string :valor
      t.integer :usuario_id
      t.timestamps
    end
  end

  def self.down
    drop_table :propostas
  end
end
