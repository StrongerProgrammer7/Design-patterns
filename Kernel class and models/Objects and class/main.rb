load './student.rb'

def get_git(student)
	student.git
end
def get_any_contacts(student)
	if(student.phone != nil)
		student.phone
	elsif(student.telegram != nil)
		student.telegram
	elsif student.mail != nil
		student.mail
	end
end
			

def validate_contacts_git(student)
	info = {}
	info["git"] = get_git(student)
	info["contact"] = get_any_contacts(student)
	return info
end

s1 = Student.new("Nn","Ssd","Lfg",phone:"87743258961",git:"https://github.com/StPr/rep.git")
s2 = Student.new("Nv","Ssd","Lfg",mail:"sw467@mail.ru")
s3 = Student.new("Ns","Ssd","Lfg",telegram:"@sdsd")
s4 = Student.new("Nd","Ssd","Lfg",phone:"+77743258961")
s5 = Student.new("Nw","Ssd","Lfg",phone:"77743258961")
s1.print_current_info
s2.print_current_info
s3.print_current_info
s4.print_current_info
s5.print_current_info

p Student.check_phone(s1.phone)
s1.phone = "+77794563215"
p Student.check_phone(s1.phone)

p validate_contacts_git(s1)
p validate_contacts_git(s2)
p validate_contacts_git(s3)