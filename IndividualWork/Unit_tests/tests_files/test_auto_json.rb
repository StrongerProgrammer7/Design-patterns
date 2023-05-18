require_relative File.dirname($0) + '/../../model_auto/auto.rb'
require_relative File.dirname($0) + '/../../model_auto/list_file/auto_list_json.rb'
require_relative File.dirname($0) + '/../../model_auto/datatable/auto_list.rb'

require 'test/unit'

class TestAuto_json < Test::Unit::TestCase
  
  def setup
	  @auto_file = Auto_list.new(Auto_list_json.new())
  end

  def test_initialize
	elem = @auto_file.get_element_by_id(1)
    assert_equal(1, elem.id_owner)
    assert_equal("Goblin", elem.surname_owner)
    assert_equal("X6", elem.model)
    assert_equal("black", elem.color)
  end
 

  def test_get_k_n
	data_list_auto = @auto_file.get_k_n_elements_list(1,2,data_list:nil)
	table = data_list_auto.getDataFromTable()
	model = table.get_element(0,1)
	model_name = table.get_element(1,1)
	id_owner = table.get_element(1,5)
	assert_equal("model", model)
	assert_equal("X6", model_name)
	assert_equal(1, id_owner)
	assert_equal("Goblin", table.get_element(1,0))
  end
 
  def test_get_elements_count
	 len = @auto_file.get_elements_count()
	 assert_equal(3, len)
  end

  def test_write_files
	elements = [
	  Auto.new(id:1,
      id_owner:1,
      surname_owner:"Goblin",
      model:"X6",
      mark:"BMW",
	  color:"black"),
	  Auto.new(id:2,
      id_owner:2,
      surname_owner: "Kupit",
      model:"Highlander",
      mark:"Toyota",
	  color:"gray"),
	  Auto.new(id:3,
      id_owner:3,
      surname_owner: "Pisa",
      model:"Rapid",
      mark:"Skoda",
	  color:"black")]
	  
	  @auto_file.write_to_file("/../../testfile/testfile_auto/","test",elements)
      
		data_list_auto = @auto_file.get_k_n_elements_list(1,3,data_list:nil)
		table = data_list_auto.getDataFromTable()
		assert_equal("Pisa",  table.get_element(3,0))
		assert_equal("Rapid", table.get_element(3,1))
	
  end

end
