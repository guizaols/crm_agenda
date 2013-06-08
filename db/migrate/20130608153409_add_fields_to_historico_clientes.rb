class AddFieldsToHistoricoClientes < ActiveRecord::Migration

  def self.up
    add_column :historico_clientes, :status, :integer
    add_column :historico_clientes, :motivo, :text
    add_column :historico_clientes, :objetivo, :text
    add_column :historico_clientes, :atividades, :text
    add_column :historico_clientes, :tipo_acao, :string
  end

  def self.down
    remove_column :historico_clientes, :status
    remove_column :historico_clientes, :motivo
    remove_column :historico_clientes, :objetivo
    remove_column :historico_clientes, :atividades
    remove_column :historico_clientes, :tipo_acao
  end

end
