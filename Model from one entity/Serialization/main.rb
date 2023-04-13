
load './persons/person.rb'
load './persons/student.rb'
load './persons/student_short.rb'

load './datatable/data_list_student_short.rb'

load './list_file/students_list_file.rb'
load './list_file/students_list_json.rb'
load './list_file/students_list_yaml.rb'
load './list_file/students_list_txt.rb'

load './datatable/students_list.rb'

load './student_list_DB.rb'


=begin
require 'mysql2'
include Mysql2
begin 
	mysql = Mysql2::Client.new(:username => 'alex', :host => 'localhost')
	mysql.query("USE Students")
	mysql.query("CREATE TABLE IF NOT EXISTS \
		Students(Id INT PRIMARY KEY AUTO_INCREMENT, Surname VARCHAR(30) NOT NULL, Name VARCHAR(30) NOT NULL,
		Lastname VARCHAR(30) NOT NULL, phone VARCHAR(15) NULL, mail VARCHAR(50) NULL, telegram VARCHAR(30) NULL,
		git VARCHAR(200) NULL)")
	mysql.query("Alter table Students Change Name Name TEXT CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;")
	mysql.query("Alter table Students Change Surname Surname TEXT CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;")
	mysql.query("Alter table Students Change Lastname Lastname TEXT CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;")
	text = File.read("./table_student/insert_students.sql")
	mysql.query(text)
	#results = mysql.query("SELECT * FROM Students").to_a
	
	#students = Array.new(results.length()) 

	#results.each do |data|
	#	students.push(Student.new(id:data['Id'],
	#		surname: data['Surname'],
	#		name: data['Name'],
	#		lastname: data['Lastname'],
	#		phone: data['phone'],
	#		telegram: data['telegram'],
	#		mail: data['mail'],
	#		git: data['git']))
	#end
	
	#print students[0].surname,"\n"	,students.length()

	#rs = mysql.query 'SELECT VERSION()'
	#print rs.fetch_row

	mysql.query("delete * from Students")
rescue Mysql2::Error => e
	print e
	#print e.Error
ensure
	
	mysql&.close
end
=end


s1 = Student.initialization("8345,Volkov,John,Dmitrief,87743258961,,,https://github.com/StPr/rep.git")
s2 = Student.initialization("8346,Lopy,John,Dmitrief,87743258961,,,https://github.com/StPr/rep.git")
stdb = Students_list_DB.new()
print s1.mail,"\n"
stdb.push_student(s1)
print stdb.get_student_short_count()
stdb.delete_element_by_id(5)
print stdb.get_student_short_count()
stdb.replace_element_by_id(1,s2)
print stdb.get_student_short_count()
s = Students_DB.getInstance()
s.crud_student_by_db("Delete FROM Students Where id = 2")




=begin
studentsList = Students_list.new(Students_list_yaml.new())
studentsList.read_from_file(File.dirname(__FILE__) + "/testfile" + "/test.yaml")
print studentsList.get_student_by_id(8536),"\n"
studentsList.format_file = Students_list_json.new()
studentsList.read_from_file(File.dirname(__FILE__) + "/testfile" + "/test.json")
print studentsList.get_student_by_id(8536) ,"\n"
print studentsList.list_students
=end