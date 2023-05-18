require_relative File.dirname($0) + '/../../model_auto/auto.rb'

require 'test/unit'

class TestAuto < Test::Unit::TestCase
  
  def setup
    @auto1 = Auto.new(id:0,
      id_owner:1,
      surname_owner:"Goblin",
      mark:"BMW",
      model:"Wolf",
      color:"black")
	  
	  @auto2 = Auto.initialization("1,2,Kupit,Highlander,Toyota,gray")
  end

  def test_initialize_auto1
    assert_equal(1, @auto1.id_owner)
    assert_equal("Goblin", @auto1.surname_owner)
    assert_equal("Wolf", @auto1.model)
    assert_equal("BMW", @auto1.mark)
    assert_equal("black", @auto1.color)
  end
  
  def test_initialize_auto2
    assert_equal(2, @auto2.id_owner)
    assert_equal("Kupit", @auto2.surname_owner)
    assert_equal("Highlander", @auto2.model)
    assert_equal("Toyota", @auto2.mark)
    assert_equal("gray", @auto2.color)
  end
  

  def test_to_s
    assert_equal("Wolf black", @auto1.to_s)
	  assert_equal("Highlander gray", @auto2.to_s)
  end

  
  def test_get_info
	 assert_equal("Kupit, Highlander, gray", @auto2.get_info())
  end
  
  def test_valid_no_special_symbol_in_model?
      assert(Auto.check_no_special_symbol("Model-75"))
      assert(Auto.check_no_special_symbol("GL-s7"))
      assert(!Auto.check_no_special_symbol("Toi@1"))
      assert(!Auto.check_no_special_symbol("POWER!"))
    end
 
end
