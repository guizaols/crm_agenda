class AdicionaEntidadeIdEmRecursos < ActiveRecord::Migration
  def self.up
    add_column :recursos,:entidade_id,:integer
  end

  def self.down
    remove_column :recursos,:entidade_id
  end
end
