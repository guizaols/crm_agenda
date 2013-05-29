class AdicionaCampoJustificativaEmRetiradas < ActiveRecord::Migration
  def self.up
    add_column :retiradas,:justificativa,:text
  end

  def self.down
    remove_column :retiradas,:justificativa
  end
end
