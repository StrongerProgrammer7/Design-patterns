require_relative File.dirname($0) + '/../../model_person/list_file/guard_list.rb'
require_relative File.dirname($0) + '/../../model_person/datatable/guards_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/Parking_list.rb'
require_relative File.dirname($0) + '/../../model_entity/entity_list/entity_adapter.rb'

require 'test/unit'

class TestGuard_db < Test::Unit::TestCase
  
  def setup
	  @guard = Parking_list.intialize_DB(:guard)
  end

  def test_initialize_guard
	elem = @guard.get_element_by_id(2)
    assert_equal("Дроздов", elem["surname"])
    assert_equal("Денис", elem["name"])
    assert_equal("Авдеевич", elem["lastname"])
    assert_equal("+75259561235", elem["phone"])
    assert_equal("guar@gmail.com",elem["mail"])
  end
  
  def test_get_k_n
	data_list_person_short = @guard.get_k_n_elements_list(1,3,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	intitlas_man = table.get_element(2,1)
	not_mail = table.get_element(2,3)
	assert_equal("Дроздов Д.А.", intitlas_man)
	assert_equal("guar@gmail.com", not_mail)
  end
  
  def test_get_elements_count
	 len = @guard.get_elements_count()
	 assert_equal(3, len)
  end
  
  def test_after_db_files_json
	@guard.strategy = Entity_adapter.new(Persons_list_json.new(person:Guard_list.new(:json)),:guard)
	data_list_person_short = @guard.get_k_n_elements_list(1,2,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	intitlas_man = table.get_element(1,1)
	not_mail = table.get_element(1,3)
	assert_equal("Пучкин С.Т.", intitlas_man)
	assert_equal("not mail", not_mail)
  end

end
