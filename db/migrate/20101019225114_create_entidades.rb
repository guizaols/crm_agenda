class CreateEntidades < ActiveRecord::Migration
  def self.up
    create_table :entidades do |t|
      t.string :nome
      t.string :nome_responsavel
      t.string :email_responsavel
      t.string :telefone_responsavel
      t.string :bairro
      t.string :numero
      t.string :cidade
      t.text :observacoes

      t.timestamps
    end
  end

  def self.down
    drop_table :entidades
  end
end
