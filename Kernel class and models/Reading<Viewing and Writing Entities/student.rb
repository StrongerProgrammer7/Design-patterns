class Student
	attr_accessor :surname, :name, :lastname
	attr_reader :ID, :phone, :telegram, :mail, :git

	def initialize(surname:,name:,lastname:, phone:nil, telegram:nil,mail:nil,git:nil)
		valid_baseField_onCorrect(name:name,surname:surname,lastname:lastname)
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

	def Student.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 2 || information.count(",") > 7)
		hash_data = Student.string_to_hash(information.split(","))
		Student.new(surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"],telegram:hash_data["telegram"],git:hash_data["git"])
	end

	def to_s()
		 #{}"ID\tname\tlastname\tphone\n"
		 "#{self.ID}  #{self.name}  #{self.surname}  #{self.phone}  "
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

	def getInfo()
		getSurname_Initials + getGit + getAnyContact
	end


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

	

	private
	@@countStudents = 0
	attr_writer :ID, :mail, :phone, :telegram, :git

	def self.isNumeric(num)
		num.split(//).each do |i|
			return false if not(("0".."9").include?(i))
		end
		return true

	end

	def self.string_to_hash(data)
		hash_data = Hash.new
		#Student.valid_baseField_onCorrect(name:data[0],surname:data[1],lastname:data[2])
		hash_data["surname"] = data[1]
		hash_data["name"]=data[0]
		hash_data["lastname"] = data[2]
		data.drop(3).each do |i|
			next if(i==nil)
			if(i.include? "@") then
				(i[0]=='@') ? hash_data["telegram"] = i : hash_data["mail"] = i
			end
			hash_data["git"] = i if(i.include? "https:\/\/github") 
			hash_data["phone"] = i if(("0".."9").include?(i[0])==true and ("0".."9").include?(i[i.length-1])==true)
		end
		#Student.valid_extraField_onCorrect(phone:hash_data["phone"],mail:hash_data["mail"],telegram:hash_data["telegram"],git:hash_data["git"])
		return hash_data
	end

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

	def valid_baseField_onCorrect(name:,surname:,lastname:)
		if( Student.check_word(surname) ==nil || Student.check_word(name)==nil || Student.check_word(lastname) == nil)
			raise "Not valid name or surname or lastname [A-Z][a-z]+"
		end
	end

	def getSurname_Initials
		"#{self.surname} #{self.name[0]}. #{self.lastname[0]}. "
	end

	def getAnyContact()
		return " phone => #{self.phone} " if(self.phone!=nil)
		return " mail => #{self.mail} " if(self.mail !=nil)
		return " telegram => #{self.telegram} " if(self.telegram!=nil)
	end

	def getGit()
		return "git => #{self.git} " if(self.git!=nil)
	end

end
