load './student.rb'
load './student_short.rb'

print "initialization\n"
s1 = Student.initialization("Ssd,Nn,Lfg,87743258961,,,https://github.com/StPr/rep.git")
s2 = Student.initialization("Ssv,Nv,Lfg,swa@mail.ru")
#s3 = Student.new(surname:"Ns",name:"Ssd",lastname:"Lfg",telegram:"@sdsd")
#s4 = Student.new(surname:"Nd",name:"Ssd",lastname:"Lfg",phone:"+77743258961")
#s5 = Student.new(surname:"Nw",name:"Ssd",lastname:"Lfg",phone:"77743258961",telegram:"@cad",mail:"s5@mail.com")

print s1.to_s() + "\n"
print s2.to_s() +"\n"
print s1.getInfo() + "\n\n"

s2.set_information(mail:"sw7a@mail.ru",telegram:"@cadet")
p s2.getInfo()


print "Short \n"
ss1 = Student_short.initialization(s1)
ss2 = Student_short.initialization(s2)#Student_short.new(id:s1.ID,information:s1.getInfo())

print ss1.contact + "\n"
print ss2.initials + "\n"

print "s2=",s2.id ," ss2=",ss2.id ,"\n"
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