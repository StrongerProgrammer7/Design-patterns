require_relative File.dirname($0) + './auto.rb'
require_relative '../../model_entity/entity_DB/entity_list_DB.rb'
require 'date'

class Auto_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		auto = @dbcon.crud_by_db("Select * FROM Auto WHERE id = #{id}").to_a
		auto[0]
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		offset = (k - 1) * n
		limit = n

		list_auto = []
		@dbcon.crud_by_db("Select * FROM Auto LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			surname_owner = @dbcon.crud_by_db("Select surname FROM Owner WHERE id = #{elem["owner_id"]};").to_a
			mark = @dbcon.crud_by_db("Select mark FROM Model WHERE model = '#{elem["model"]}';").to_a
			auto = Auto.new(
					id:elem["id"],
					id_owner:Integer(elem["owner_id"]),
					surname_owner: surname_owner[0]["surname"],
      				model:elem["model"],
      				mark:mark[0]["mark"],
      				color:elem["color"])
			list_auto.push(auto)
		end

		if(data_list == nil) then
			return Data_list_auto.new(list_auto)
		else
			return data_list.list_entities = list_auto
		end
	end

	def push_element(element)
		auto = create_auto(element:element,id:0)
		@dbcon.crud_by_db("INSERT INTO Auto
			(owner_id,name, model, color) 
			VALUES 
			('#{auto.id_owner}','#{auto.model}','#{auto.color}');")
	end

	def replace_element_by_id(id,element)
		auto = create_auto(element:element,id:id)
		@dbcon.crud_by_db("UPDATE Auto SET owner_id = '#{auto.id_owner}', model = '#{auto.model}',color = '#{auto.color}'
		WHERE id = #{id};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_by_db("Delete from Auto WHERE id = #{id}")
	end

	def get_elements_count()
		return @dbcon.crud_by_db("Select count(*) FROM Auto").to_a[0]['count(*)']
	end
	
	private 
	def create_auto(element:,id:nil)
		 Auto.new(id:id,
					id_owner:Integer(element["owner_id"]),
					surname_owner:element["surname_owner"],
      				model:element["model"],
      				mark:element["mark"],
      				color:element["color"])
	end

end