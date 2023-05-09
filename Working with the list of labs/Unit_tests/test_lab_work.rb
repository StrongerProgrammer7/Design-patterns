require_relative File.dirname($0) + './model_lab/laboratory_work.rb'

require 'test/unit'

class TestLab_work < Test::Unit::TestCase
  
  def setup
    @lab = Laboratory_work.new(id:0,
      name:"Public",
      topics:"Log",
      tasks:"1.Create logger",
      date:"13.04.2022")
  end

  def test_initialize
    assert_equal("Public", @lab.name)
    assert_equal("Log", @lab.topics)
    assert_equal("1.Create logger", @lab.tasks)
    assert_equal("13.04.2022", @lab.date)
  end

  def test_to_s
    assert_equal("Public Log 13.04.2022", @lab.to_s)
  end


  def test_valid?
      assert(Laboratory_work.check_word("Labs"))
      assert(Laboratory_work.check_date("13.04.2021"))
      assert(!Laboratory_work.check_word("some_se1"))
      assert(!Laboratory_work.check_date("15-s0.2021"))
    end
 
end
