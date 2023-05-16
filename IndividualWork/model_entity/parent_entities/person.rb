class Person
	attr_reader :surname, :name, :lastname ,:phone, :mail 
	attr_accessor :id
	
	define_singleton_method :check_phone do |phone|
		/^(\+7|8)[0-9]{9,15}$/.match(phone)
	end

	define_singleton_method :check_word do |word|
		/^[A-ZА-Я]([a-z]+|[a-яё]+)$/.match(word)
	end

	define_singleton_method :check_mail do |mail|
		/^[A-z0-9.]+@[a-z0-9]+\.[a-z]+$/.match(mail)
	end

	def initialize(surname:,name:,lastname:,phone:,mail:nil)
		set_information(surname:surname,name:name,lastname:lastname, phone:phone,mail:mail)
	end

	def to_s()
		"#{self.surname} #{self.name}"
	end

	def get_all_contacts()
		"#{self.phone}, #{self.mail}"
	end
	
	def get_Info()
		mail = get_mail()
		if mail != "" then mail = ",#{mail}" end
		"#{get_initials()}, #{self.phone} #{mail}"
	end
	
	def set_information(surname:nil,name:nil,lastname:nil, phone:nil,mail:nil)
		set_baseInfo(surname:surname,name:name,lastname:lastname)
		set_extraInfo(phone:phone,mail:mail)
	end
	
	
	private
		attr_writer :surname, :name, :lastname ,:phone, :mail
		
		def set_baseInfo(surname:nil,name:nil,lastname:nil)
			valid_baseField_onCorrect(name:name,surname:surname,lastname:lastname)
			self.surname = surname if(surname!=nil)
			self.name = name if(name != nil)
			self.lastname = lastname if(lastname !=nil)
		end

		def set_extraInfo(phone:nil,mail:nil)
			valid_extraField_onCorrect(phone:phone,mail:mail)		
			self.phone=phone if(phone!=nil and phone != '')
			self.mail = mail if(mail!=nil and mail!='') 
		end
	
		def get_initials
			lastname = if(self.lastname!= '' && self.lastname!=nil) then "#{self.lastname[0]}." else "" end
			"#{self.surname} #{self.name[0]}.#{lastname}"
		end

		def get_mail()
			if(self.mail) then self.mail else "" end
		end

		def valid_baseField_onCorrect(name:,surname:,lastname:)
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

		def valid_extraField_onCorrect(phone:,mail:)
			valid_contact(phone:phone,mail:mail)	
		end
	
		def valid_contact(phone:,mail:)
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
		end
	
end