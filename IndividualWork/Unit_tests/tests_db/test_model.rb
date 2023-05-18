require_relative File.dirname($0) + '/../../model_auto/list_file/model/model_list_json.rb'
require_relative File.dirname($0) + '/../../model_auto/datatable/model_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/Parking_list.rb'
require 'test/unit'

class TestModel_db < Test::Unit::TestCase
  
  def setup
	  @model = Parking_list.intialize_DB(:model)
  end

  def test_initialize
		elem = @model.get_element_by_id("X6")
		print elem,"\n"
    assert_equal("BMW", elem["mark"])
    assert_equal("X6", elem["model"])
  end
  
  def test_get_k_n
		data_list_mark = @model.get_k_n_elements_list(1,3,data_list:nil)
		table = data_list_mark.getDataFromTable()
		mark_name = table.get_element(0,0)
		model = table.get_element(1,0)
		assert_equal("model", mark_name)
		assert_equal("X6", model)
  end
  
  def test_get_elements_count
	 len = @model.get_elements_count()
	 assert_equal(3, len)
  end

  def test_after_db_files_json
		@model.strategy = Entity_adapter.new(Model_list_json.new(),:model)
		data_list= @model.get_k_n_elements_list(1,2,data_list:nil)
		table = data_list.getDataFromTable()
		model = table.get_element(0,0)
		name = table.get_element(1,0)
		assert_equal("model", model)
		assert_equal("X6", name)
  end

end
