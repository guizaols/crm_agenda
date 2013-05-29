require File.dirname(__FILE__) + '/lib/dinheiro_field'
ActiveRecord::Base.send :extend, DinheiroField
