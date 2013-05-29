class AdicionaEntidadeIdEmAuditoria < ActiveRecord::Migration
  def self.up
    add_column :auditorias,:entidade_id,:integer
  end

  def self.down
    add_column :auditorias,:entidade_id
  end
end
