class AdicionaCampoEmailContatoTelefoneContatoDaEmpresaIi < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:telefone_contato,:string
    add_column :pessoas,:email_contato,:string
  end

  def self.down
  end
end
