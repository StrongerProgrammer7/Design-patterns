
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
s3 = Student.initialization("8347,Потапов,Михаил,Иванович,,swaf@mail.ru,,")
s4 = Student.initialization("8348,Бирюков,Ким,Мэлорович,,,@telega,https://github.com/StPr/rep.git")
stdb = Students_list_DB.new()
print s1.mail,"\n"
stdb.push_student(s1)
stdb.push_student(s2)
stdb.push_student(s3)
stdb.push_student(s4)
print stdb.get_student_short_count(),"\n"
print stdb.get_k_n_student_short_list(1,2)
stdb.delete_element_by_id(95)
print stdb.get_student_short_count() ,"\n"
stdb.replace_element_by_id(90,s2)
print stdb.get_student_short_count(), "\n"



=begin
print "initialization\n"
s1 = Student.initialization("Ssd,Nn,Lfg,87743258961,,,https://github.com/StPr/rep.git")
s2 = Student.initialization("Ssv,Nv,Lfg,swa@mail.ru")

print s1.to_s() + "\n"
print s2.to_s() +"\n"
print s1.getInfo() + "\n\n"

s2.set_information(mail:"sw7a@mail.ru",telegram:"@cadet")
p s2.getInfo()
=end

=begin
print "Short \n"
ss1 = Student_short.initialization(s1)
ss2 = Student_short.initialization(s2)#Student_short.new(id:s1.ID,information:s1.getInfo())
#ss3 = Student_short.new(surname:"Ss1",name:"Ns1",lastname:"Ls1")

print "ss1\n"
print ss1.contact + "\n"
print ss1.git
print "\n"
print ss2.initials + "\n"
print "s2=",s2.id ," ss2=",ss2.id ,"\n"
=end

=begin
print "Data list short \n"
array = [ss1,ss2]
dl = Data_list_student_short.new(array)
dataTable = dl.getDataFromTable()
print dataTable.get_element(0,0),"\n";
print dataTable.get_element(0,1),"\n";
print dataTable.get_element(0,2),"\n";
print dataTable.get_element(1,2),"\n";

dl.select(0)
dl.select(1)
print dl.get_selected()
=end

=begin
print "\n\n read_from_txt \n"
students = s1.read_from_txt(File.dirname(__FILE__) + "testfile" + "/read_from_txt")

p students[0].getInfo() + "\n"
p students[1].getInfo() + "\n"


print "\n\n write_to_txt\n"
s1.write_to_txt(File.dirname(__FILE__)/testfile,"test",students)
print "\nread_from_write_to_txt\n"
students1 = s1.read_from_txt(File.dirname(__FILE__) + "testfile" + "/test")

p students1[0].getInfo() +"\n"
p students1[1].getInfo() + "\n"
=end

=begin
print JSON, "\n"
test =  Students_list_json.new(File.dirname(__FILE__) + "testfile" + "/test.json")
test.write_to_json(File.dirname(__FILE__),"json_write",test.read_from_json(File.dirname(__FILE__) + "testfile" +"/test.json"))
print test.read_from_json(File.dirname(__FILE__) + "testfile" + "/json_write.json")
=end
=begin
print YAML, "\n"

test1 = Students_list_yaml.new(File.dirname(__FILE__) + "/testfile" + "/test.yaml")
test1.write_to_yaml(File.dirname(__FILE__),"/yaml_write", test1.read_from_yaml(File.dirname(__FILE__) + "/testfile" +"/test.yaml"))
=end

=begin
studentsList = Students_list.new(Students_list_yaml.new())
studentsList.read_from_file(File.dirname(__FILE__) + "/testfile" + "/test.yaml")
print studentsList.get_student_by_id(8536),"\n"
studentsList.format_file = Students_list_json.new()
studentsList.read_from_file(File.dirname(__FILE__) + "/testfile" + "/test.json")
print studentsList.get_student_by_id(8536) ,"\n"
print studentsList.list_students
=end