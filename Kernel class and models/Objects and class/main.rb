load './student.rb'


s1 = Student.new("n1","s1","l1",phone:"87743258961")
s2 = Student.new("n2","s2","l2",phone:"+77743258961")
s3 = Student.new("n3","s3","l3",phone:"87743258961")
s4 = Student.new("n4","s4","l4",phone:"+77743258961")
s5 = Student.new("n5","s5","l5",phone:"77743258961")
s1.print_current_info
s2.print_current_info
s3.print_current_info
s4.print_current_info
s5.print_current_info

p Student.check_phone(s1.phone)
s1.phone = "+77794563215"
p Student.check_phone(s1.phone)