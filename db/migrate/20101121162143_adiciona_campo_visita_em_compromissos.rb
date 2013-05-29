class AdicionaCampoVisitaEmCompromissos < ActiveRecord::Migration
  def self.up
    add_column :tipo_compromissos,:visita_externa,:boolean
    
  end

  def self.down
    remove_column :compromissos,:visita_externa
  end
end
