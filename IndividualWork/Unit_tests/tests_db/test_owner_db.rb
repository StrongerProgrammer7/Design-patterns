require_relative File.dirname($0) + '/../../model_person/list_file/owner_list.rb'
require_relative File.dirname($0) + '/../../model_person/datatable/owners_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/Parking_list.rb'
require 'test/unit'

class TestOwner_db < Test::Unit::TestCase
  
  def setup
	  @owner = Parking_list.intialize_DB(:owner)
  end

  def test_initialize_owner
	elem = @owner.get_element_by_id(1)
    assert_equal("Яковлев", elem["surname"])
    assert_equal("Леон", elem["name"])
    assert_equal("Тимофеевич", elem["lastname"])
    assert_equal("89374225252", elem["phone"])
    assert_equal(nil,elem["mail"])
  end
  
  def test_get_k_n
	data_list_person_short = @owner.get_k_n_elements_list(1,3,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	initials = table.get_element(0,1)
	intitlas_man = table.get_element(1,1)
	not_mail = table.get_element(1,3)
	assert_equal("initials", initials)
	assert_equal("Яковлев Л.Т.", intitlas_man)
	assert_equal("not mail", not_mail)
  end
  
  def test_get_elements_count
	 len = @owner.get_elements_count()
	 assert_equal(3, len)
  end

end
