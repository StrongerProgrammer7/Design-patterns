load './student.rb'

def get_git(student)
	student.git
end



def get_all_contacts(student)
	contacts = {}
	if(student.phone != nil)
		contacts["phone"] = student.phone
	end
	if(student.telegram != nil)
		contacts["telegram"] = student.telegram
	end 
	if(student.mail != nil)
		contacts["mail"] = student.mail
	end
	return contacts
end

def validate_contacts_git(student,phone:nil,mail:nil,telegram:nil)
	info = {}
	info["git"] = get_git(student)
	info["contact"] = get_any_contacts(student,phone:phone,mail:mail,telegram:telegram)
	return info
end

s1 = Student.new(surname:"Nn",name:"Ssd",lastname:"Lfg",phone:"87743258961",git:"https://github.com/StPr/rep.git")
s2 = Student.new(surname:"Nv",name:"Ssd",lastname:"Lfg",mail:"sw467@mail.ru")
s3 = Student.new(surname:"Ns",name:"Ssd",lastname:"Lfg",telegram:"@sdsd")
s4 = Student.new(surname:"Nd",name:"Ssd",lastname:"Lfg",phone:"+77743258961")
s5 = Student.new(surname:"Nw",name:"Ssd",lastname:"Lfg",phone:"77743258961",telegram:"@cad",mail:"s5@mail.com")
p s1.to_s
p s2.to_s
p s3.to_s
p s4.to_s
p s5.to_s

p Student.check_phone(s1.phone)
#s1.phone = "+77794563215"
#p Student.check_phone(s1.phone)

s1.set_contacts(phone:"87743258961",telegram:"@cadet")
p s1.get_all_contacts()

#p validate_contacts_git(s1)
#p validate_contacts_git(s2)
#p validate_contacts_git(s3)
#p get_all_contacts(s1)
