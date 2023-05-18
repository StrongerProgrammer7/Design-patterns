require_relative File.dirname($0) + './mark.rb'
require_relative '../../model_entity/entity_DB/entity_list_DB.rb'
require 'date'

class Mark_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		mark = @dbcon.crud_by_db("Select * FROM Mark WHERE mark = '#{id}'").to_a
		mark[0]
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		offset = (k - 1) * n
		limit = n

		list_mark = []
		@dbcon.crud_by_db("Select * FROM Mark LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			mark = Mark.new(mark:elem["mark"])
			list_mark.push(mark)
		end

		if(data_list == nil) then
			return Data_list_mark.new(list_mark)
		else
			return data_list.list_entities = list_mark
		end
	end

	def push_element(element)
		mark = create_mark(element:element,id:0)
		@dbcon.crud_by_db("INSERT INTO Mark(mark) 
			VALUES 
			('#{mark.mark}');")
	end

	def replace_element_by_id(id,element)
		mark = create_mark(element:element,id:id)
		@dbcon.crud_by_db("UPDATE Mark SET mark = '#{mark.mark}' WHERE mark = #{mark.mark};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_by_db("Delete from Mark WHERE mark = #{id}")
	end

	def get_elements_count()
		@dbcon.crud_by_db("Select count(*) FROM Mark").to_a[0]['count(*)']
	end
	
	private 
	def create_mark(element:,id:nil)
		 Mark.new(mark:element["mark"])
	end

end