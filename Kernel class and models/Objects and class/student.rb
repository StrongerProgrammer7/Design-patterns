class Student
	attr_accessor :surname, :name, :lastname, :phone, :telegram, :mail, :git
	attr_reader :ID

	def initialize(surname,name,lastname, phone:nil, telegram:nil,mail:nil,git:nil)
		if( Student.check_letter(surname) ==nil && Student.check_letter(name)==nil && Student.check_letter(lastname) == nil)
			raise "Not valid name or surname or lastname [A-Z][a-z]+"
		end
		valid_extra_field(phone:phone,telegram:telegram,mail:mail,git:git)
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

	define_singleton_method :check_phone do |phone|
		/\+?[0-9]{11,13}/.match(phone)
	end

	define_singleton_method :check_letter do |word|
		/^[A-Z][a-z]+/.match(word)
	end

	define_singleton_method :check_mail do |mail|
		/^[A-z0-9]+@[a-z0-9]+\.[a-z]+/.match(mail)
	end

	define_singleton_method :check_telegram do |telegram|
		/^@[A-z0-9]/.match(telegram)
	end
	define_singleton_method :check_git do |git|
		/^https:\/\/github\.com\/[A-z0-9]*\/[A-z0-9]*\.git/.match(git)
	end
	private
	@@countStudents = 0
	attr_writer :ID

	def valid_extra_field(phone:nil,mail:nil,telegram:nil,git:nil)
		if(phone!=nil)
			if Student.check_phone(phone) ==nil then
			 	raise "Not valid phone"
			end
		end
		if(mail!=nil)
			if(Student.check_mail(mail)==nil) then
				raise "Not valid mail"
			end
		end
		if(telegram!=nil)
			if(Student.check_telegram(telegram)==nil) then
				raise "Not valid telegram"
			end
		end
		if(git!=nil)
			if(Student.check_git(git)==nil) then
				raise "Not valid git"
			end
		end
	end
end
