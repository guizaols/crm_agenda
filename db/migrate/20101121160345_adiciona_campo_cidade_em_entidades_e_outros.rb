class AdicionaCampoCidadeEmEntidadesEOutros < ActiveRecord::Migration
  def self.up
    add_column :entidades,:cep,:string
    add_column :entidades,:endereco,:string
  end

  def self.down
  end
end
