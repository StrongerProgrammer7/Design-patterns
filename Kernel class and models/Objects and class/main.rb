load './student.rb'


s1 = Student.new("Nn","Ssd","Lfg",phone:"87743258961")
s2 = Student.new("Nv","Ssd","Lfg",phone:"+77743258961")
s3 = Student.new("Ns","Ssd","Lfg",phone:"87743258961")
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

p Student.check_mail("sdads2sda@mail.ru")