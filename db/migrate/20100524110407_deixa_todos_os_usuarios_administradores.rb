class DeixaTodosOsUsuariosAdministradores < ActiveRecord::Migration
  def self.up
    Usuario.all.each do |u|
        u.perfil_id = 1
        u.save!
    end
  end

  def self.down
  end
end
