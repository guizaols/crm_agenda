class AdicionaRecursoIdEmRetirada < ActiveRecord::Migration
  def self.up
   add_column :retiradas,:recurso_id,:integer
  end

  def self.down
    remove_column :retiradas,:recurso_id
  end
end
