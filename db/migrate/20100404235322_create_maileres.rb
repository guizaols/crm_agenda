class CreateMaileres < ActiveRecord::Migration
  def self.up
    create_table :maileres do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :maileres
  end
end
