class AdicionaCamposEmNegociacao < ActiveRecord::Migration
  def self.up
    add_column :propostas,:valor_entrada,:string
    add_column :propostas,:quantidade,:integer
    add_column :propostas,:veiculo_financiado,:boolean
    add_column :propostas,:financiamento_numero_parcelas,:integer
    add_column :propostas,:financiamento_valor_parcelas,:string
    add_column :propostas,:usado,:string
    add_column :propostas,:avaliacao_usado,:text


  end

  def self.down
  end
end
