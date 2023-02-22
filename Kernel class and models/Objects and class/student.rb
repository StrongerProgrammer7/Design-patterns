class Student
	attr_accessor :surname, :name, :lastname, :phone, :telegram, :mail, :git
	attr_reader :ID
	
	def initialize(surname,name,lastname, phone:nil, telegram:nil,mail:nil,git:nil)
		self.name = name
		self.surname = surname
		self.lastname = lastname
		self.phone = phone
		self.telegram = telegram
		self.mail = mail
		self.git = git
		self.ID = @@countStudents
		@@countStudents = @@countStudents + 1
	end

	private
	@@countStudents = 0
	attr_writer :ID
end
