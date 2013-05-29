require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require File.dirname(__FILE__) + '/database_setup'

class DinheiroFieldTest < Test::Unit::TestCase
  
  require File.expand_path(File.dirname(__FILE__) + "/../init")
  
  class Venda < ActiveRecord::Base; 
    dinheiro_field :valor, :outro_valor
    data_br_field  :data, :outra_data
    usar_campo_sem_acento :titulo
  end
  
  def setup
    @nova_venda = Venda.new
  end
  
  def test_dinheiro_field_method_with_multiple_fields
    assert_equal nil, @nova_venda.valor
    assert_equal nil, @nova_venda.outro_valor
  end
  
  def test_dinheiro_field_method_with_integer_value  
    @nova_venda.valor = 100
    assert_equal "100,00", @nova_venda.valor_before_type_cast
    assert_equal 100, @nova_venda.valor
    assert_instance_of Float, @nova_venda.valor
  end

  def test_dinheiro_field_receber_valor_dinheiro
    @nova_venda.valor = Dinheiro.new("200")
    assert_equal 200, @nova_venda.valor
  end
  
  def test_dinheiro_field_with_wrong_value
    @nova_venda.valor = "200,0003"
    assert_equal nil, @nova_venda.valor
  end
  
  def test_dinheiro_field_method_with_normal_values  
    @nova_venda.valor = "200,01"
    assert_equal '200,01', @nova_venda.valor_before_type_cast
    assert_equal 200.01, @nova_venda.valor

    @nova_venda.valor = "123.45"
    assert_equal "123,45", @nova_venda.valor_before_type_cast
  end 
    
  def test_dinheiro_field_method_with_blank_value  
    @nova_venda.valor = ""
    assert_equal nil, @nova_venda.valor
  end
  
  def test_data_br_field_method
    assert_equal "", @nova_venda.data
    
    @nova_venda.data = "2008-12-31"
    assert_equal "31/12/2008", @nova_venda.data
    assert_equal "31/12/2008", @nova_venda.data_before_type_cast

    @nova_venda.data = "31/12/2007"
    assert_equal "31/12/2007", @nova_venda.data
    
    @nova_venda.data = "31/12/08"
    assert_equal "31/12/2008", @nova_venda.data
    
    @nova_venda.data = "05/07/97"
    assert_equal "05/07/1997", @nova_venda.data
    
    @nova_venda.data = "06/07/30"
    assert_equal "06/07/2030", @nova_venda.data
    
    @nova_venda.data = Date.new 2008,5,8
    assert_equal "08/05/2008", @nova_venda.data
    
    @nova_venda.data = "data invalida"
    assert_equal "", @nova_venda.data
    
    @nova_venda.outra_data = "30/07/2005"
    assert_equal "30/07/2005", @nova_venda.outra_data
    
    @nova_venda.data = '6/6/2006'
    assert_equal "06/06/2006", @nova_venda.data
    
    ano_atual = Time.now.year
    @nova_venda.data = '01/10'
    assert_equal "01/10/#{ano_atual}", @nova_venda.data
  end
  
  def test_presence_of_brazilian_rails_plugin
    assert_nothing_raised "O plugin brazilian-rails deve estar instalado" do
      assert_equal "R$ 10,00", Dinheiro.new("10").real_contabil
    end
  end
  
  def test_usar_campo_sem_acento
    @nova_venda.titulo = 'Félipé'
    @nova_venda.save!
    assert_equal 'Felipe', @nova_venda.titulo_sem_acento
  end
  
end
