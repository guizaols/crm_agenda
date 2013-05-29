class AdicionaPessoaIdEmCompromisso < ActiveRecord::Migration
  def self.up
    add_column :compromissos,:pessoa_id,:integer
  end

  def self.down
    remove_column :compromissos,:pessoa_id
  end
end
