require_relative File.dirname($0) + './datatable/data_list_student_short.rb'
require_relative File.dirname($0) + './persons/student_short.rb'

require 'mysql2'
include Mysql2

class Students_DB

	def self.getInstance()
		if @@mysql.nil?
			@@mysql = Mysql2::Client.new(:username => 'alex', :host => 'localhost')
			@@mysql.query("USE Students")
		end
		if @@inst.nil?
			@@inst = Students_DB.new()
		end
		@@inst	
	end
			
	def crud_student_by_db(query)
		begin
			@@mysql.query(query)
		rescue Mysql2::Error => e
			print e
		end
	end

	private 
		@@mysql = nil 
		@@inst = nil
	
end

class Students_list_DB

	def initialize()
		@dbcon = Students_DB.getInstance()
	end 
	
	def get_student_by_id(id)
		student = @dbcon.crud_student_by_db("Select * FROM Students WHERE id = #{id}").to_a
		student = clearData(student[0])
		return student
	end

	def get_k_n_student_short_list(k,n,data_list:nil,filter_git:nil)
		offset = (k - 1) * n
		limit = n

		list_students_short = []

		select_ = "Select * FROM Students"
		if(filter_git!=nil) then
			if(filter_git != "not have git") then
				select_ = "Select * FROM Students WHERE git LIKE '%#{filter_git}%' AND git != ''"
			else
				select_ = "Select * FROM Students WHERE git = 'NULL' OR git = '' OR git IS NULL"
			end
		end

		select_ += " LIMIT #{limit} OFFSET #{offset};"
		@dbcon.crud_student_by_db("#{select_}").to_a.each do |elem|
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

	def push_student(student)
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

	def get_student_short_count()
		return @dbcon.crud_student_by_db("Select count(*) FROM Students").to_a[0]['count(*)']
	end
	
	private 
		@dbcon = nil

	def clearData(elem)
		elem["mail"] = change_NULL_to_empty(elem["mail"])
		elem["phone"] = change_NULL_to_empty(elem["phone"])
		elem["telegram"] = change_NULL_to_empty(elem["telegram"])
		elem["git"] = change_NULL_to_empty(elem["git"])
		elem["Lastname"] = if elem["Lastname"] == "" then nil else elem["Lastname"] end
		return elem
	end

	def change_NULL_to_empty(elem)
		if(elem.to_s.include? "NULL") then return "" else return elem end
	end
end