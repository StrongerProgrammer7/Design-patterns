require_relative File.dirname($0) + '/../../model_person/list_file/owner_list.rb'
require_relative File.dirname($0) + '/../../model_entity/parent_entities/person.rb'
require_relative File.dirname($0) + '/../../model_person/datatable/owners_list.rb'

require 'test/unit'

class TestOwner_json < Test::Unit::TestCase
  
  def setup
	  @owner_file = Owners_list.new(Persons_list_json.new(person:Owner_list.new(:json)))
  end

  def test_initialize_owner
	elem = @owner_file.get_element_by_id(1)
    assert_equal("Калмыков", elem.surname)
    assert_equal("Сергей", elem.name)
    assert_equal("Тимурович", elem.lastname)
    assert_equal("89374324535", elem.phone)
    assert_equal(nil,elem.mail)
  end
 
  
  def test_get_k_n
	data_list_person_short = @owner_file.get_k_n_elements_list(1,2,data_list:nil)
	table = data_list_person_short.getDataFromTable()
	initials = table.get_element(0,1)
	intitlas_man = table.get_element(1,1)
	not_mail = table.get_element(1,3)
	assert_equal("initials", initials)
	assert_equal("Калмыков С.Т.", intitlas_man)
	assert_equal("not mail", not_mail)
  end
  
  def test_get_elements_count
	 len = @owner_file.get_elements_count()
	 assert_equal(3, len)
  end

  def test_write_files
	elements = [
	  Owner.new(id:1,
      surname:"Калмыков",
      name:"Сергей",
      lastname:"Тимурович",
      phone:"89374324535"),
	  Owner.new(id:2,
      surname:"Крылов",
      name:"Александр",
      lastname:"Ильич",
      phone:"+79374324585",
      mail:"swaf@mail.ru"),
	  Owner.new(id:3,
      surname:"Gordon",
      name:"Wolf",
      lastname:"Malrov",
      phone:"+79374552595",
      mail:"mail@mail.com")]
	  
	  @owner_file.write_to_file("/../../testfile/testfile_owners/","test",elements)
      
		data_list_person_short = @owner_file.get_k_n_elements_list(1,3,data_list:nil)
		table = data_list_person_short.getDataFromTable()
		intitlas_man = table.get_element(3,1)
		mail = table.get_element(3,3)
		assert_equal("Gordon W.M.", intitlas_man)
		assert_equal("mail@mail.com", mail)
	
  end

end
