require_relative File.dirname($0) + './model.rb'
require_relative '../../model_entity/entity_DB/entity_list_DB.rb'
require 'date'

class Model_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		model = @dbcon.crud_by_db("Select * FROM Model WHERE model = '#{id}'").to_a
		model[0]
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		offset = (k - 1) * n
		limit = n

		list_model = []
		@dbcon.crud_by_db("Select * FROM Model LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			model = Model.new(model:elem["model"],mark:elem["mark"])
			list_model.push(model)
		end

		if(data_list == nil) then
			return Data_list_model.new(list_model)
		else
			return data_list.list_entities = list_model
		end
	end

	def push_element(element)
		model = create_model(element:element,id:0)
		@dbcon.crud_by_db("INSERT INTO Model(model,mark) 
			VALUES 
			('#{model.model},#{model.mark}');")
	end

	def replace_element_by_id(id,element)
		model = create_model(element:element,id:id)
		@dbcon.crud_by_db("UPDATE Model SET model = '#{model.model}' ,mark = '#{model.mark}' WHERE model = #{model.model};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_by_db("Delete from Model WHERE model = #{id}")
	end

	def get_elements_count()
		@dbcon.crud_by_db("Select count(*) FROM Model").to_a[0]['count(*)']
	end
	
	private 
	def create_model(element:,id:nil)
		 Model.new(model:element["model"],mark:element["mark"])
	end

end