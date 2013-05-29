class AdicionaCampoExisteUsado < ActiveRecord::Migration
  def self.up
        add_column :propostas,:existe_usado,:boolean

  end

  def self.down
  end
end
