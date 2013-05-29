class AdicionaCampoAprovacaoTecnicaAprovacaoAdministrativa < ActiveRecord::Migration
  def self.up
    add_column :suportes,:aprovacao_tecnica,:boolean
    add_column :suportes,:aprovacao_adminsitrativa,:boolean
  end

  def self.down
    remove_column
  end
end
