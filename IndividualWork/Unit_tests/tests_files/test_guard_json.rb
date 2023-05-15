require_relative File.dirname($0) + '/../../model_person/list_file/guard_list.rb'
require_relative File.dirname($0) + '/../../model_entity/parent_entities/person.rb'
require_relative File.dirname($0) + '/../../model_person/datatable/guards_list.rb'

require 'test/unit'

class TestGuard_json < Test::Unit::TestCase
  
  def setup
	  @guard_file = Guards_list.new(Persons_list_json.new(person:Guard_list.new(:json)))
  end

  def test_initialize_guard
	elem = @guard_file.get_element_by_id(1)
    assert_equal("Пучкин", elem.surname)
    assert_equal("Сергей", elem.name)
    assert_equal("Тимурович", elem.lastname)
    assert_equal("89374324535", elem.phone)
    assert_equal(nil,elem.mail)
	assert_equal(0,elem.exp_year)
  end
 

  def test_get_k_n
	data_list_person_short = @guard_file.get_k_n_elements_list(1,2,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	initials = table.get_element(0,1)
	intitlas_man = table.get_element(1,1)
	not_mail = table.get_element(1,3)
	assert_equal("initials", initials)
	assert_equal("Пучкин С.Т.", intitlas_man)
	assert_equal("not mail", not_mail)
  end
 
  def test_get_elements_count
	 len = @guard_file.get_elements_count()
	 assert_equal(3, len)
  end

  def test_write_files
	elements = [
	  Guard.new(id:1,
      surname:"Пучкин",
      name:"Сергей",
      lastname:"Тимурович",
      phone:"89374324535",
	  exp_year:0),
	  Guard.new(id:2,
      surname:"Малюга",
      name:"Александр",
      lastname:"Ильич",
      phone:"+79374324585",
      mail:"swaf@mail.ru",
	  exp_year:5),
	  Guard.new(id:3,
      surname:"Gordon",
      name:"Wolf",
      lastname:"Malrov",
      phone:"+79374552595",
      mail:"mail@mail.com",
	  exp_year:10)]
	  
	  @guard_file.write_to_file("/../../testfile/testfile_guards/","test",elements)
      
		data_list_person_short = @guard_file.get_k_n_elements_list(1,3,data_list:nil)
		table = data_list_person_short.getDataFromTable()
		intitlas_man = table.get_element(3,1)
		mail = table.get_element(3,3)
		assert_equal("Gordon W.M.", intitlas_man)
		assert_equal("mail@mail.com", mail)
  end

end
