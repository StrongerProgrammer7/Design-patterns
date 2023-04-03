
load './persons/person.rb'
load './persons/student.rb'
load './persons/student_short.rb'

load './datatable/data_list_student_short.rb'

load './list_file/students_list_file.rb'
load './list_file/students_list_json.rb'
load './list_file/students_list_yaml.rb'
load './list_file/students_list_txt.rb'

load './datatable/students_list.rb'

require 'mysql2'
include Mysql2
begin 
	mysql = Mysql2::Client.new(:username => 'student', :password => '123', :host => 'localhost')
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
	results = mysql.query("SELECT * FROM Students")

	print results
	results.each do |row|
		print row["Id"].to_s() + " || "
	end 
	#rs = mysql.query 'SELECT VERSION()'
	#print rs.fetch_row

rescue Mysql2::Error => e
	print e
	#print e.Error

ensure
	mysql.query("delete from Students")
	mysql.close if mysql
end


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