require_relative File.dirname($0) + './model_student/persons/student.rb'
require_relative File.dirname($0) + './model_student/persons/person.rb'

require 'test/unit'

class TestStudent < Test::Unit::TestCase
  
  def setup
    @student = Student.new(id:0,
      surname:"Gordon",
      name:"Vokl",
      lastname:"",
      phone:"+79374552595",
      telegram:"@telega",
      mail:"mail@mail.com",
      git: "https://github.com/StrPrg/Des.git")
  end

  def test_initialize
    assert_equal("Gordon", @student.surname)
    assert_equal("Vokl", @student.name)
    assert_equal("", @student.lastname)
    assert_equal("+79374552595", @student.phone)
    assert_equal("@telega", @student.telegram)
    assert_equal("mail@mail.com", @student.mail)
    assert_equal("https://github.com/StrPrg/Des.git", @student.git)
  end

  def test_to_s
    assert_equal("Gordon Vokl ", @student.to_s)
  end

  def test_to_s_not_correct
    assert_equal("Gordon Volk ", @student.to_s)
  end

  def test_valid_email?
      assert(Person.check_mail("john.doe@example.com"))
      assert(!Person.check_mail("jane.doe@example.co.uk"))
      assert(!Person.check_mail("jane.doeexample.com"))
      assert(!Person.check_mail("jane.doe@.com"))
    end
 
end
