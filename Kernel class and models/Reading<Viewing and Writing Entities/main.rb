load './student.rb'


s1 = Student.initialization("Nn,Ssd,Lfg,87743258961,https://github.com/StPr/rep.git")
s2 = Student.initialization("Nv,Ssd,Lfg,swa@mail.ru")
#s3 = Student.new(surname:"Ns",name:"Ssd",lastname:"Lfg",telegram:"@sdsd")
#s4 = Student.new(surname:"Nd",name:"Ssd",lastname:"Lfg",phone:"+77743258961")
#s5 = Student.new(surname:"Nw",name:"Ssd",lastname:"Lfg",phone:"77743258961",telegram:"@cad",mail:"s5@mail.com")
print s1.to_s() + "\n"
print s2.to_s() +"\n"
print s1.getInfo() + "\n"
#print s3.to_s()
#print s4.to_s()
#print s5.to_s()
#p s1.name
#p Student.check_phone(s1.phone)


#s1.set_contacts(mail:"swa@mail.ru",telegram:"@cadet")
#p s1.get_all_contacts()


