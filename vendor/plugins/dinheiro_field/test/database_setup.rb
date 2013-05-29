require 'test/unit'
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "vendor/plugins/dinheiro_field/test/test.db"
)

ActiveRecord::Schema.define do
  create_table :vendas, :force => true do |t|
    t.column :valor,             :float
    t.column :outro_valor,       :float
    t.column :data,              :date
    t.column :titulo,            :string
    t.column :titulo_sem_acento, :string
  end  
end
