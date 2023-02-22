class Student
	attr_accessor :surname, :name, :lastname, :phone, :telegram, :mail, :git
	attr_reader :ID

	def initialize(surname,name,lastname, phone:nil, telegram:nil,mail:nil,git:nil)
		self.surname = surname
		self.name = name
		self.lastname = lastname
		self.phone = phone
		self.telegram = telegram
		self.mail = mail
		self.git = git
		self.ID = @@countStudents
		@@countStudents = @@countStudents + 1
	end

	def print_current_info()
		print "ID\tname\tlastname\tphone\n"
		print "#{self.ID}\t#{self.name}\t#{self.surname}\t#{self.phone}\n"
	end

	private
	@@countStudents = 0
	attr_writer :ID
end
