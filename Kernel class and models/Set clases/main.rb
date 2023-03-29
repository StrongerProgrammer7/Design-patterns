load './students_list_txt.rb'
load('data_list_student_short.rb')
load './student.rb'
load './student_short.rb'
load './students_list_json.rb'

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
students = s1.read_from_txt(File.dirname(__FILE__) + "/read_from_txt")

p students[0].getInfo() + "\n"
p students[1].getInfo() + "\n"


print "\n\n write_to_txt\n"
s1.write_to_txt(File.dirname(__FILE__),"test",students)
print "\nread_from_write_to_txt\n"
students1 = s1.read_from_txt(File.dirname(__FILE__) + "/test")

p students1[0].getInfo() +"\n"
p students1[1].getInfo() + "\n"
=end

print "\n"
test =  Students_list_json.new(File.dirname(__FILE__) + "/test.json")
print test.read_from_json(File.dirname(__FILE__) + "/test.json")