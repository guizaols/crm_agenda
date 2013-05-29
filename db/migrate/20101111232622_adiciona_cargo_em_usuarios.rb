class AdicionaCargoEmUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios,:cargo,:string
  end

  def self.down
  end
end
