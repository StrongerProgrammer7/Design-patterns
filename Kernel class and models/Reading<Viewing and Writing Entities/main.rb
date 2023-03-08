load './student.rb'


s1 = Student.initialization("Nn,Ssd,Lfg,87743258961,https://github.com/StPr/rep.git")
s2 = Student.initialization("Nv,Ssd,Lfg,swa@mail.ru")
#s3 = Student.new(surname:"Ns",name:"Ssd",lastname:"Lfg",telegram:"@sdsd")
#s4 = Student.new(surname:"Nd",name:"Ssd",lastname:"Lfg",phone:"+77743258961")
#s5 = Student.new(surname:"Nw",name:"Ssd",lastname:"Lfg",phone:"77743258961",telegram:"@cad",mail:"s5@mail.com")
print s1.to_s() + "\n"
print s2.to_s() +"\n"
print s1.getInfo() + "\n"

#s1.set_contacts(mail:"swa@mail.ru",telegram:"@cadet")
#p s1.get_all_contacts()

ss2 = Student_short.initialization(s2)
ss1 = Student_short.new(id:s1.ID,information:s1.getInfo())
print ss1.contact + "\n"
print ss2.initials + "\n"