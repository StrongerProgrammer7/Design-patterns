require_relative File.dirname($0) + '/../../model_auto/list_file/mark/mark_list_json.rb'
require_relative File.dirname($0) + '/../../model_auto/datatable/mark_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/Parking_list.rb'
require 'test/unit'

class TestMark_db < Test::Unit::TestCase
  
  def setup
	  @mark = Parking_list.intialize_DB(:mark)
  end

  def test_initialize
		elem = @mark.get_element_by_id("BMW")
    assert_equal("BMW", elem["mark"])
  end
  
  def test_get_k_n
		data_list_mark = @mark.get_k_n_elements_list(1,3,data_list:nil)
		table = data_list_mark.getDataFromTable()
		mark_name = table.get_element(0,0)
		mark = table.get_element(1,0)
		assert_equal("mark", mark_name)
		assert_equal("BMW", mark)
  end
  
  def test_get_elements_count
	 len = @mark.get_elements_count()
	 assert_equal(3, len)
  end
  def test_after_db_files_json
		@mark.strategy = Entity_adapter.new(Mark_list_json.new(),:mark)
		data_list= @mark.get_k_n_elements_list(1,2,data_list:nil)
		table = data_list.getDataFromTable()
		mark = table.get_element(0,0)
		mark_name = table.get_element(1,0)
		assert_equal("mark", mark)
		assert_equal("BMW", mark_name)
  end
end
