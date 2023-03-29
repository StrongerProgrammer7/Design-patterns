class Person
	attr_reader :id,  :surname, :name, :lastname ,:phone, :telegram, :mail,:git 

	define_singleton_method :check_phone do |phone|
		/\+?[0-9]{11,13}$/.match(phone)
	end

	define_singleton_method :check_word do |word|
		/^[A-Z][a-z]+$/.match(word)
	end

	define_singleton_method :check_mail do |mail|
		/^[A-z0-9]+@[a-z0-9]+\.[a-z]+$/.match(mail)
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
		"#{self.surname} ,#{self.name} ,#{self.lastname}"
	end
		
	private
		attr_writer :id,  :surname, :name, :lastname ,:phone, :telegram, :mail,:git

		def set_baseInfo(surname:nil,name:nil,lastname:nil)
			valid_baseField_onCorrect(name,surname,lastname)
			self.surname = surname if(surname!=nil)
			self.name = name if(name != nil)
			self.lastname = lastname if(lastname !=nil)
		end

		def set_extraInfo(phone:nil,telegram:nil,mail:nil,git:nil)
			valid_extraField_onCorrect(phone:phone,mail:mail,telegram:telegram,git:git)		
			self.phone=phone if(phone!=nil)
			self.mail = mail if(mail!=nil) 
			self.telegram = telegram if(telegram!=nil)
			self.git = git if(git!=nil)
		end


		def getSurname_Initials
			"#{self.surname} #{self.name[0]}. #{self.lastname[0]}. "
		end

		def getGit()
			isExistsGit() ? ", #{self.git} " : "have't git"
		end

		def isExistsGit()
			self.git!=nil
		end

		def isExistsAnyContact()
			getAnyContact()!=nil
		end

		def valid_baseField_onCorrect(name,surname,lastname)
			if(surname!=nil) then
				raise "Not valid surname [A-Z][a-z]+"  if(Person.check_word(surname) == nil)
				self.surname=surname 
			end
			if(name!=nil) then
				raise "Not valid name [A-Z][a-z]+"  if(Person.check_word(name) == nil)
				self.name=name 
			end
			if(lastname!=nil) then
				raise "Not valid lastname [A-Z][a-z]+"  if(Person.check_word(lastname) == nil)
				self.lastname=lastname 
			end
		end

		def valid_extraField_onCorrect(phone:nil,mail:nil,telegram:nil,git:nil)
			valid_contact(phone:phone,mail:mail,telegram:telegram)
			valid_git(git:git)	
		
		end
	
		def valid_contact(phone:nil,mail:nil,telegram:nil)
			if(phone!=nil)
				if Person.check_phone(phone) ==nil then
				 	raise "Not valid phone"
				end
			end
			if(mail!=nil)
				if(Person.check_mail(mail)==nil) then
					raise "Not valid mail"
				end
			end
			if(telegram!=nil)
				if(Person.check_telegram(telegram)==nil) then
					raise "Not valid telegram"
				end
			end
		end
	
		def valid_git(git:nil)
			if(git!=nil)
				if(Person.check_git(git)==nil) then
					raise "Not valid git"
				end
			end
		end
end