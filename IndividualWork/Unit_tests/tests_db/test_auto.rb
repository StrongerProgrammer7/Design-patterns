require_relative File.dirname($0) + '/../../model_auto/list_file/auto_list_json.rb'
require_relative File.dirname($0) + '/../../model_auto/datatable/auto_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/Parking_list.rb'
require 'test/unit'

class TestAuto_db < Test::Unit::TestCase
  
  def setup
	  @auto = Parking_list.intialize_DB(:auto)
  end

  def test_initialize
	elem = @auto.get_element_by_id(1)
    assert_equal(1, elem["owner_id"])
    assert_equal("Higlander", elem["model"])
    assert_equal("black", elem["color"])
  end
  
  def test_get_k_n
	data_list_person_short = @auto.get_k_n_elements_list(1,3,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	model = table.get_element(0,1)
	highlander = table.get_element(1,1)
	surname = table.get_element(1,0)
	color = table.get_element(1,2)
	assert_equal("model", model)
	assert_equal("Яковлев", surname)
	assert_equal("Higlander", highlander)
	assert_equal("black", color)
  end
  
  def test_get_elements_count
	 len = @auto.get_elements_count()
	 assert_equal(3, len)
  end
  
  def test_after_db_files_json
	@auto.strategy = Entity_adapter.new(Auto_list_json.new(),:auto)
	data_list_auto = @auto.get_k_n_elements_list(1,2,data_list:nil)
	table = data_list_auto.getDataFromTable()
	model = table.get_element(0,1)
	model_name = table.get_element(1,1)
	id_owner = table.get_element(1,4)
	assert_equal("model", model)
	assert_equal("X6", model_name)
	assert_equal(1, id_owner)
  end

end
