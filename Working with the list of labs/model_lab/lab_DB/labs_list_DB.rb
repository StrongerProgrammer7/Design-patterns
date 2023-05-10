require_relative File.dirname($0) + './laboratory_work.rb'
require_relative '../../model_entity/entity_DB/entity_list_DB.rb'

class Labs_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		lab = @dbcon.crud_student_by_db("Select * FROM Laboratory_work WHERE id = #{id}").to_a
		lab = clearData(lab[0])
		lab
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		offset = (k - 1) * n
		limit = n

		list_labs = []
		@dbcon.crud_student_by_db("Select * FROM Laboratory_work LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			elem = clearData(elem)
			lab = Laboratory_work.new(
					id:elem["Id"],
      				name:elem["name"],
      				topics:elem["topics"],
      				tasks:elem["tasks"],
      				date:elem["date"])
			list_labs.push(lab)
		end

		if(data_list == nil) then
			return Data_list_student_short.new(list_labs)
		else
			return data_list.list_entities = list_labs
		end
	end

	def push_element(lab)
		@dbcon.crud_student_by_db("INSERT INTO Laboratory_work(name, topics, tasks, date) VALUES ('#{lab.name}','#{lab.topics || 'NULL'}','#{lab.tasks || 'NULL'}','#{lab.date}');")
	end

	def replace_element_by_id(id,element)
		@dbcon.crud_student_by_db("UPDATE Laboratory_work 
							SET name = '#{element.name}', topics = '#{element.topics}', 
							tasks = '#{element.tasks}',
							date = '#{element.date}'
							WHERE id = #{id};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_student_by_db("Delete from Laboratory_work WHERE id = #{id}")
	end

	def get_elements_count()
		return @dbcon.crud_student_by_db("Select count(*) FROM Laboratory_work").to_a[0]['count(*)']
	end
	
	private 

	def clearData(elem)
		elem["topics"] = change_NULL_to_empty(elem["topics"])
		elem["tasks"] = change_NULL_to_empty(elem["tasks"])
		elem
	end

	def change_NULL_to_empty(elem)
		if(elem.to_s.include? "NULL") then return "" else return elem end
	end
end