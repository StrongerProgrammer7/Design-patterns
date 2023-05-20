require_relative '../../model_entity/entity_DB/entity_list_DB.rb'
require_relative '../../model_entity/Decorator/Persons_filter/mail_decorator.rb'
require_relative '../../model_entity/Decorator/Persons_filter/surname_decorator.rb'
require_relative '../../model_entity/Decorator/Persons_filter/phone_decorator.rb'

class Owners_list_DB < Entities_list_DB

	def initialize()
		super(query_select:"Select * FROM Owner WHERE ")
	end 
	
	def get_element_by_id(id)
		owner = @dbcon.crud_by_db("Select * FROM Owner WHERE id = #{id}").to_a[0]
		owner = clearData(owner) if owner != nil
		return owner
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil,
		filter_color:nil,filter_model:nil,filter_mark:nil,filter_owner:nil)
		offset = (k - 1) * n
		limit = n

		query = Mail_decorator.new(filter_mail,Phone_decorator.new(filter_phone,
			Surname_decorator.new(filter_initials,
				Owners_list_DB.new()))).query_select

		query = query + " LIMIT #{limit} OFFSET #{offset};"

		list_persons_short = []
		@dbcon.crud_by_db(query).to_a.each do |elem|
			elem = clearData(elem)
			owner = Owner.new(id:elem["id"],surname:elem["surname"],name:elem["name"],lastname:elem["lastname"], phone:elem["phone"],mail:elem["mail"])
			person_short = Person_short.initialization(owner)
			list_persons_short.push(person_short)
		end

		if(data_list == nil) then
			return Data_list_person_short.new(list_persons_short)
		else
			return data_list.list_entities = list_persons_short
		end
	end

	def push_element(element)
		owner = create_owner(element)
		@dbcon.crud_by_db("INSERT INTO Owner(surname, name, lastname, phone, mail) 
		VALUES ('#{owner.surname}','#{owner.name}','#{owner.lastname}','#{owner.phone}','#{owner.mail || 'NULL'}');")
	end

	def replace_element_by_id(id,element)
		owner = create_owner(element)
		@dbcon.crud_by_db("UPDATE Owner 
							SET surname = '#{owner.surname}', name = '#{owner.name}', 
							lastname = '#{owner.lastname}',
							phone = '#{owner.phone}', mail = '#{owner.mail || 'NULL'}'
							WHERE id = #{id};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_by_db("Delete from Owner WHERE id = #{id}")
	end

	def get_elements_count()
		return @dbcon.crud_by_db("Select count(*) FROM Owner").to_a[0]['count(*)']
	end
	
	private 
	
	def create_owner(element)
		Owner.new(id:0,surname:element["surname"],name:element["name"],lastname:element["lastname"],phone:element["phone"],mail:element["mail"])
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