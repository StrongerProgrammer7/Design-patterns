class Student
	attr_accessor :surname, :name, :lastname
	attr_reader :ID, :phone, :telegram, :mail, :git
	def initialize(surname:,name:,lastname:, phone:nil, telegram:nil,mail:nil,git:nil)
		valid_baseField_onCorrect(name,surname,lastname)
		valid_extraField_onCorrect(phone:phone,telegram:telegram,mail:mail,git:git)
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

	def to_s()
		 #{}"ID\tname\tlastname\tphone\n"
		 "#{self.ID}  #{self.name}  #{self.surname}  #{self.phone}  "
	end

	define_singleton_method :check_phone do |phone|
		/\+?[0-9]{11,13}/.match(phone)
	end

	define_singleton_method :check_word do |word|
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

	def set_contacts(phone:nil,mail:nil,telegram:nil)
		valid_extraField_onCorrect(phone:phone,mail:mail,telegram:telegram)		
		if(phone!=nil) then
			self.phone=phone 
		end
		if(mail!=nil) then
			self.mail = mail
		end
		if(telegram!=nil) then
			self.telegram = telegram
		end
	end

	def get_all_contacts()
		contacts = {}
		contacts["phone"] =self.phone
		contacts["telegram"] = self.telegram
		contacts["mail"] = self.mail
		return contacts
	end

	private
	@@countStudents = 0
	attr_writer :ID, :mail, :phone, :telegram, :git

	def valid_contact(phone:nil,mail:nil,telegram:nil)
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
	end

	def valid_git(git:nil)
		if(git!=nil)
			if(Student.check_git(git)==nil) then
				raise "Not valid git"
			end
		end
	end

	def valid_extraField_onCorrect(phone:nil,mail:nil,telegram:nil,git:nil)
		valid_contact(phone:phone,mail:mail,telegram:telegram)
		valid_git(git:git)	
	
	end

	def valid_baseField_onCorrect(name,surname,lastname)
		if( Student.check_word(surname) ==nil && Student.check_word(name)==nil && Student.check_word(lastname) == nil)
			raise "Not valid name or surname or lastname [A-Z][a-z]+"
		end
	end
end
