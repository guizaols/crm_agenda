class AdicionaCampoGrupoIdEmPessoas < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:grupo_id,:integer
  end

  def self.down
    remove_column :pessoas,:grupo_id
  end
end
