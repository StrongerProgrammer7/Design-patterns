require_relative File.dirname($0) + '/../../model_person/persons/guard.rb'
require_relative File.dirname($0) + '/../../model_entity/parent_entities/person.rb'

require 'test/unit'

class TestGuard < Test::Unit::TestCase
  
  def setup
    @guard_1 = Guard.new(id:0,
      surname:"Gordon",
      name:"Wolf",
      lastname:"Malrov",
      phone:"+79374552595",
      mail:"mail@mail.com",
	  exp_year:0)	
	  
	  @guard_2 = Guard.initialization("2,Karlik,Max,Pug,89652563245,mail72@mail.com,5")
  end

  def test_initialize_owner1
    assert_equal("Gordon", @guard_1.surname)
    assert_equal("Wolf", @guard_1.name)
    assert_equal("Malrov", @guard_1.lastname)
    assert_equal("+79374552595", @guard_1.phone)
    assert_equal("mail@mail.com", @guard_1.mail)
	assert_equal(0, @guard_1.exp_year)
  end
  
  def test_initialize_owner2
    assert_equal("Karlik", @guard_2.surname)
    assert_equal("Max", @guard_2.name)
    assert_equal("Pug", @guard_2.lastname)
    assert_equal("89652563245", @guard_2.phone)
    assert_equal("mail72@mail.com", @guard_2.mail)
	assert_equal(5, @guard_2.exp_year)
  end
  


  def test_to_s
    assert_equal("Gordon Wolf 0", @guard_1.to_s)
	assert_equal("Karlik Max 5", @guard_2.to_s)
  end

  
  def test_get_info
	 assert_equal("Karlik M.P., 89652563245 ,mail72@mail.com", @guard_2.get_Info())
	 assert_equal("Gordon W.M., +79374552595 ,mail@mail.com", @guard_1.get_Info())
  end
   
end
