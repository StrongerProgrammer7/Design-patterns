require_relative File.dirname($0) + '/../../model_person/persons/owner.rb'
require_relative File.dirname($0) + '/../../model_entity/parent_entities/person.rb'

require 'test/unit'

class TestOwner < Test::Unit::TestCase
  
  def setup
    @owner_1 = Owner.new(id:0,
      surname:"Gordon",
      name:"Wolf",
      lastname:"Malrov",
      phone:"+79374552595",
      mail:"mail@mail.com")
	 @owner_2 = Owner.new(id:1,
      surname:"Kulic",
      name:"Vokl",
      lastname:"",
      phone:"+79374558595",
      mail:"")
	  
	  @owner_3 = Owner.initialization("2,Karlik,Max,Pug,89652563245,mail72@mail.com")
  end

  def test_initialize_owner1
    assert_equal("Gordon", @owner_1.surname)
    assert_equal("Wolf", @owner_1.name)
    assert_equal("Malrov", @owner_1.lastname)
    assert_equal("+79374552595", @owner_1.phone)
    assert_equal("mail@mail.com", @owner_1.mail)
  end
  
  def test_initialize_owner2
    assert_equal("Kulic", @owner_2.surname)
    assert_equal("Vokl", @owner_2.name)
    assert_equal("", @owner_2.lastname)
    assert_equal("+79374558595", @owner_2.phone)
    assert_equal(nil, @owner_2.mail)
  end
  
  def test_initialize_owner3
    assert_equal("Karlik", @owner_3.surname)
    assert_equal("Max", @owner_3.name)
    assert_equal("Pug", @owner_3.lastname)
    assert_equal("89652563245", @owner_3.phone)
    assert_equal('mail72@mail.com', @owner_3.mail)
  end

  def test_to_s
    assert_equal("Gordon Wolf", @owner_1.to_s)
	assert_equal("Kulic Vokl", @owner_2.to_s)
	assert_equal("Karlik Max", @owner_3.to_s)
  end

  
  def test_get_info
	 assert_equal("Kulic V., +79374558595 ", @owner_2.get_Info())
	 assert_equal("Gordon W.M., +79374552595 ,mail@mail.com", @owner_1.get_Info())
  end
  


  def test_valid_phone?
      assert(Person.check_phone("+79374552595"))
      assert(Person.check_phone("89374552595"))
      assert(!Person.check_phone("+7937-4552595434"))
      assert(!Person.check_phone("+18779374552595"))
    end
 
end
