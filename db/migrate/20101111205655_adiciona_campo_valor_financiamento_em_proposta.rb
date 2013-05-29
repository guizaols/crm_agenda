class AdicionaCampoValorFinanciamentoEmProposta < ActiveRecord::Migration
  def self.up
    add_column :propostas,:valor_financiado,:string
  end

  def self.down
  end
end
