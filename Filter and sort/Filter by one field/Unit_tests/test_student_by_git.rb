require_relative File.dirname($0) + './student_list/student_list.rb'

require 'test/unit'

class TestStudent_Fiter_by_git < Test::Unit::TestCase
  
  def setup
    @student = Student_list.new(Students_list_DB.new())
  end

  def test_get_k_n_student_short_by_have_git
    list = @student.get_k_n_student_short_list(1,1,filter_git:"S")
    table = list.getDataFromTable()
    elemt = table.get_element(1,3)
    assert_equal(" https://github.com/StPr/rep.git", elemt)
  end

  def test_get_k_n_student_short_by_empty_git
    list = @student.get_k_n_student_short_list(1,1,filter_git:"not have git")
    table = list.getDataFromTable()
    elemt = table.get_element(1,3)
    assert_equal("not have git", elemt)
  end
 
end
