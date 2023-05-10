require_relative File.dirname($0) + './datatable/data_list_student_short.rb'
require_relative File.dirname($0) + './persons/student_short.rb'

require_relative '../../model_entity/entity_DB/entity_list_DB.rb'

class Students_list_DB < Entities_list_DB

	def initialize()
		super()
	end 
	
	def get_element_by_id(id)
		student = @dbcon.crud_student_by_db("Select * FROM Students WHERE id = #{id}").to_a
		student = clearData(student[0])
		return student
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		offset = (k - 1) * n
		limit = n

		list_students_short = []
		@dbcon.crud_student_by_db("Select * FROM Students LIMIT #{limit} OFFSET #{offset};").to_a.each do |elem|
			elem = clearData(elem)
			student = Student.new(id:elem["Id"],surname:elem["Surname"],name:elem["Name"],lastname:elem["Lastname"], phone:elem["phone"], telegram:elem["telegram"],mail:elem["mail"],git:elem["git"])
			student_short = Student_short.initialization(student)
			list_students_short.push(student_short)
		end

		if(data_list == nil) then
			return Data_list_student_short.new(list_students_short)
		else
			return data_list.list_entities = list_students_short
		end
	end

	def push_element(student)
		@dbcon.crud_student_by_db("INSERT INTO Students(Surname, Name, Lastname, phone, mail, telegram,
		git) VALUES ('#{student.surname}','#{student.name}','#{student.lastname}','#{student.phone || 'NULL'}','#{student.mail || 'NULL'}','#{student.telegram || 'NULL'}','#{student.git || 'NULL'}');")
	end

	def replace_element_by_id(id,element)
		@dbcon.crud_student_by_db("UPDATE Students 
							SET Surname = '#{element.surname}', Name = '#{element.name}', 
							Lastname = '#{element.lastname}',
							phone = '#{element.phone}', mail = '#{element.mail}', 
							git = '#{element.git}', telegram = '#{element.telegram}'
							WHERE id = #{id};")
	end

	def delete_element_by_id(id)
		@dbcon.crud_student_by_db("Delete from Students WHERE id = #{id}")
	end

	def get_elements_count()
		return @dbcon.crud_student_by_db("Select count(*) FROM Students").to_a[0]['count(*)']
	end
	
	private 
	

	def clearData(elem)
		elem["mail"] = change_NULL_to_empty(elem["mail"]) if elem["mail"] != nil
		elem["phone"] = change_NULL_to_empty(elem["phone"]) if elem["phone"] != nil
		elem["telegram"] = change_NULL_to_empty(elem["telegram"]) if elem["telegram"] != nil
		elem["git"] = change_NULL_to_empty(elem["git"]) if elem["git"] != nil
		elem["Lastname"] = if elem["Lastname"] == "" then nil else elem["Lastname"] end
		return elem
	end

	def change_NULL_to_empty(elem)
		if(elem.to_s.include? "NULL") then return "" else return elem end
	end
end