class InsereOrigemIdEmPessoas < ActiveRecord::Migration
  def self.up
    add_column :pessoas,:origem_id,:integer
  end

  def self.down
  end
end
