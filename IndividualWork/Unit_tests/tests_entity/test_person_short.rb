require_relative File.dirname($0) + '/../../model_person/persons/owner.rb'
require_relative File.dirname($0) + '/../../model_person/persons/person_short.rb'
require_relative File.dirname($0) + '/../../model_entity/parent_entities/person.rb'

require 'test/unit'

class TestPerson_short < Test::Unit::TestCase
  
  def setup
    owner_1 = Owner.new(id:0,
      surname:"Gordon",
      name:"Wolf",
      lastname:"Malrov",
      phone:"+79374552595",
      mail:"mail@mail.com")
    @person = Person_short.initialization(owner_1)
  end

  def test_initialize
    assert_equal(" +79374552595 ", @person.contact)
    assert_equal("Gordon W.M.", @person.initials)
  end

  def test_to_s
    assert_equal("Gordon W.M.", @person.to_s)
  end

 
end
