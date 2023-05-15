require_relative File.dirname($0) + '/../../model_auto/model.rb'
require_relative File.dirname($0) + '/../../model_auto/mark.rb'

require 'test/unit'

class Test_model_mark < Test::Unit::TestCase
  
  def setup
    @model = Model.new(
      model:"X6",
      mark:"BMW")
	  
	  @mark = Mark.initialization("BMW")
  end

  def test_initialize_model
    assert_equal("X6", @model.model)
    assert_equal("BMW", @model.mark)
  end
  
  def test_initialize_mark
    assert_equal("BMW", @mark.mark)
  end
  

  def test_to_s
    assert_equal("BMW X6", @model.to_s)
	assert_equal("BMW", @mark.to_s)
  end
 
end
