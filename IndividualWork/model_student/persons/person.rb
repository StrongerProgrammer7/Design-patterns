class Person
	attr_reader :surname, :name, :lastname ,:phone, :telegram, :mail,:git 
	attr_accessor :id
	define_singleton_method :check_phone do |phone|
		/\+?[0-9]{9,15}$/.match(phone)
	end

	define_singleton_method :check_word do |word|
		/^[A-ZА-Я]([a-z]+|[a-яё]+)$/.match(word)
	end

	define_singleton_method :check_mail do |mail|
		/^[A-z0-9.]+@[a-z0-9]+\.[a-z]+$/.match(mail)
	end

	define_singleton_method :check_telegram do |telegram|
		/^@[A-z0-9]/.match(telegram)
	end
	define_singleton_method :check_git do |git|
		/^https:\/\/github\.com\/[A-z0-9]*\/[A-z0-9]*\.git/.match(git)
	end

	def initialize(surname:,name:,lastname:)
		set_baseInfo(surname:surname,name:name,lastname:lastname)
	end

	def to_s()
		"#{self.surname} #{self.name} #{self.lastname}"
	end

	def get_all_contacts()
		"#{self.phone},#{self.telegram},#{self.mail}"
	end
	
	def set_baseInfo(surname:,name:,lastname:nil)
		valid_baseField_onCorrect(name,surname,lastname)
		self.surname = surname if(surname!=nil)
		self.name = name if(name != nil)
		self.lastname = lastname if(lastname !=nil)
	end

	def set_extraInfo(phone:nil,telegram:nil,mail:nil,git:nil)
		valid_extraField_onCorrect(phone:phone,mail:mail,telegram:telegram,git:git)		
		self.phone=phone if(phone!=nil and phone != '')
		self.mail = mail if(mail!=nil and mail!='') 
		self.telegram = telegram if(telegram!=nil and telegram != '')
		self.git = git if(git!=nil and git != '')
	end

	private
		attr_writer :surname, :name, :lastname ,:phone, :telegram, :mail,:git


		def getSurname_Initials
			lastname = if(self.lastname!= '' && self.lastname!=nil) then "#{self.lastname[0]}." else "" end
			"#{self.surname} #{self.name[0]}. #{lastname} "
		end

		def getGit()
			isExistsGit() ? "#{self.git}" : "have't git"
		end

		def isExistsGit()
			self.git!=nil
		end

		def isExistsAnyContact()
			getAnyContact()!=nil
		end

		def valid_baseField_onCorrect(name,surname,lastname)
			if(surname!=nil) then
				raise "Not valid surname [A-Z][a-z]+ #{surname}"  if(Person.check_word(surname) == nil)
			end
			if(name!=nil) then
				raise "Not valid name [A-Z][a-z]+ #{name}"  if(Person.check_word(name) == nil)
			end
			if(lastname!=nil && lastname != "") then
				raise "Not valid lastname [A-Z][a-z]+ #{lastname}"  if(Person.check_word(lastname) == nil)
			end
		end

		def valid_extraField_onCorrect(phone:nil,mail:nil,telegram:nil,git:nil)
			valid_contact(phone:phone,mail:mail,telegram:telegram)
			valid_git(git:git)	
		
		end
	
		def valid_contact(phone:nil,mail:nil,telegram:nil)
			if(phone!=nil and phone != '')
				if Person.check_phone(phone) ==nil then
				 	raise "Not valid phone #{phone}"
				end
			end
			if(mail!=nil and mail != '')
				if(Person.check_mail(mail)==nil) then
					raise "Not valid mail #{mail}"
				end
			end
			if(telegram!=nil and telegram != '')
				if(Person.check_telegram(telegram)==nil) then
					raise "Not valid telegram #{telegram}"
				end
			end
		end
	
		def valid_git(git:nil)
			if(git!=nil and git != '')
				if(Person.check_git(git)==nil) then
					raise "Not valid git #{git}"
				end
			end
		end
end