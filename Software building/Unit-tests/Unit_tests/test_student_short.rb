require_relative File.dirname($0) + './persons/student.rb'
require_relative File.dirname($0) + './persons/person.rb'
require_relative File.dirname($0) + './persons/student_short.rb'

require 'test/unit'

class TestStudent_short < Test::Unit::TestCase
  
  def setup
    student = Student.new(id:0,
      surname:"Gordon",
      name:"Vokl",
      lastname:"",
      phone:"+79374552595",
      telegram:"@telega",
      mail:"mail@mail.com",
      git: "")
    @student = Student_short.initialization(student)
  end

  def test_initialize
    assert_equal("phone => +79374552595", @student.contact)
    assert_equal("not have git", @student.git)
  end

  def test_to_s
    assert_equal("Gordon V.  ", @student.to_s)
  end


  def test_valid_email?
      assert(Person.check_telegram("@telega"))
      assert(!Person.check_telegram("@@telga"))
      assert(!Person.check_telegram("tel@le"))
      assert(!Person.check_telegram("tle@"))
  end
 
end
