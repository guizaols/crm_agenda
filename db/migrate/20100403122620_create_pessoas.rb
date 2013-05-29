class CreatePessoas < ActiveRecord::Migration
  def self.up
    create_table :pessoas do |t|
      t.string :nome
      t.string :rg_ie
      t.string :cpf
      t.string :cnpj
      t.string :razao_social
      t.string :contato
      t.integer :tipo_pessoa
      t.string :endereco
      t.string :complemento
      t.string :numero
      t.string :cidade
      t.string :bairro
      t.string :email
      t.string :telefone
      t.text :observacoes
      t.timestamps
    end
  end

  def self.down
    drop_table :pessoas
  end
end
