class Person
	attr_reader :id,  :surname, :name, :lastname ,:git 

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

	def to_s()
		"#{self.surname} ,#{self.name} ,#{self.lastname}"
	end
		
	private
		attr_writer :id,  :surname, :name, :lastname ,:git

		def set_baseInfo(surname:nil,name:nil,lastname:nil)
			valid_baseField_onCorrect(name,surname,lastname)
			self.surname = surname if(surname!=nil)
			self.name = name if(name != nil)
			self.lastname = lastname if(lastname !=nil)
		end

		def getSurname_Initials
			"#{self.surname} #{self.name[0]}. #{self.lastname[0]}. "
		end

		def getGit()
			self.git!=nil ? ", git => #{self.git} " : "have't git"
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
end