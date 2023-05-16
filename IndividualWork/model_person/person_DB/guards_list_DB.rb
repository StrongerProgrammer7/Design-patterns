require_relative '../../model_entity/entity_DB/entity_list_DB.rb'

class Guards_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		guard = @dbcon.crud_by_db("Select * FROM Guard WHERE id = #{id}").to_a
		guard = clearData(guard[0])
		return guard
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		offset = (k - 1) * n
		limit = n

		list_persons_short = []
		@dbcon.crud_by_db("Select * FROM Guard LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			elem = clearData(elem)
			guard = Guard.new(id:elem["id"],
			surname:elem["surname"],name:elem["name"],lastname:elem["lastname"],
			phone:elem["phone"],
			mail:elem["mail"],
			exp_year:elem["exp_year"])
			person_short = Person_short.initialization(guard)
			list_persons_short.push(person_short)
		end

		if(data_list == nil) then
			return Data_list_person_short.new(list_persons_short)
		else
			return data_list.list_entities = list_persons_short
		end
	end

	def push_element(element)
		guard = create_guard(element)
		@dbcon.crud_by_db("INSERT INTO Guard(surname, name, lastname, phone, mail,exp_year) 
		VALUES ('#{guard.surname}','#{guard.name}','#{guard.lastname}','#{guard.phone}','#{guard.mail || 'NULL'}','#{guard.exp_year}');")
	end

	def replace_element_by_id(id,element)
		guard = create_guard(element)
		@dbcon.crud_by_db("UPDATE Guard 
							SET surname = '#{guard.surname}', name = '#{guard.name}', 
							lastname = '#{guard.lastname}',
							phone = '#{guard.phone}', 
							mail = '#{guard.mail || 'NULL'}',
							exp_year = '#{guard.exp_year}'
							WHERE id = #{id};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_by_db("Delete from Guard WHERE id = #{id}")
	end

	def get_elements_count()
		return @dbcon.crud_by_db("Select count(*) FROM Guard").to_a[0]['count(*)']
	end
	
	private 
	
	def create_guard(element)
		Guard.new(id:0,surname:element["surname"],name:element["name"],lastname:element["lastname"],phone:element["phone"],mail:element["mail"],exp_year:element["exp_year"])
	end

	def clearData(elem)
		elem["mail"] = change_NULL_to_empty(elem["mail"]) if elem["mail"] != nil
		elem["lastname"] = if elem["lastname"] == "" then nil else elem["lastname"] end
		return elem
	end

	def change_NULL_to_empty(elem)
		if(elem.to_s.include? "NULL") then return "" else return elem end
	end
end