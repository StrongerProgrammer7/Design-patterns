load './student.rb'

def get_git(student)
	student.git
end
def get_any_contacts(student,phone:nil,mail:nil,telegram:nil)
	if(student.phone != nil and mail == nil and telegram == nil)
		student.phone
	elsif(student.telegram != nil and mail == nil and phone == nil)
		student.telegram
	elsif student.mail != nil and phone == nil and telegram == nil
		student.mail
	end
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

def set_contacts(student,phone:nil,mail:nil,telegram:nil)
	if(phone!=nil) then
		Student.check_phone(phone)? student.phone=phone : p
	end
	if(mail!=nil) then
		Student.check_mail(mail)? student.mail = mail : p
	end
	if(telegram!=nil) then
		Student.check_telegram(telegram)? student.telegram = telegram : p
	end
end

s1 = Student.new("Nn","Ssd","Lfg",phone:"87743258961",git:"https://github.com/StPr/rep.git")
s2 = Student.new("Nv","Ssd","Lfg",mail:"sw467@mail.ru")
s3 = Student.new("Ns","Ssd","Lfg",telegram:"@sdsd")
s4 = Student.new("Nd","Ssd","Lfg",phone:"+77743258961")
s5 = Student.new("Nw","Ssd","Lfg",phone:"77743258961",telegram:"@cad",mail:"s5@mail.com")
s1.print_current_info
s2.print_current_info
s3.print_current_info
s4.print_current_info
s5.print_current_info

p Student.check_phone(s1.phone)
s1.phone = "+77794563215"
p Student.check_phone(s1.phone)

set_contacts(s1,phone:"87743258961",telegram:"@cadet")

p validate_contacts_git(s1)
p validate_contacts_git(s2)
p validate_contacts_git(s3)
p get_all_contacts(s1)
