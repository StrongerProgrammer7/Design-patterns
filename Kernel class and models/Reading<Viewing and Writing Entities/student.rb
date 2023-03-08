class Student
	attr_accessor :surname, :name, :lastname
	attr_reader :ID, :phone, :telegram, :mail, :git

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
		hash_data = Student.string_to_hash(information.delete(' ').split(","))
		Student.new(surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"],telegram:hash_data["telegram"],git:hash_data["git"])
	end

	def to_s()
		 "#{self.surname} ,#{self.name} ,#{self.lastname}"
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
		"#{self.phone},#{self.telegram},#{self.mail}"
	end

	def getInfo()
		"#{getSurname_Initials()} #{getGit()} #{getAnyContact()}"
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
		hash_data["surname"] = data[0]
		hash_data["name"]=data[1]
		hash_data["lastname"] = data[2]
		data.drop(3).each do |i|
			next if(i==nil)
			if(i.include? "@") then
				(i[0]=='@') ? hash_data["telegram"] = i : hash_data["mail"] = i
			end
			hash_data["git"] = i if(i.include? "https:\/\/github") 
			hash_data["phone"] = i if(("0".."9").include?(i[0])==true and ("0".."9").include?(i[i.length-1])==true)
		end
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
protected
	def getSurname_Initials
		"#{self.surname} #{self.name[0]}. #{self.lastname[0]}. "
	end

	def getAnyContact()
		return ",phone => #{self.phone} " if(self.phone!=nil)
		return ",mail => #{self.mail} " if(self.mail !=nil)
		return ",telegram => #{self.telegram} " if(self.telegram!=nil)
		return ",have't contact" if(self.phone==nil and self.mail==nil and self.telegram==nil)
	end

	def getGit()
		 self.git!=nil ? ", git => #{self.git} " : "have't git"
	end

end

class Student_short < Student
	attr_reader :ID, :initials, :git, :contact

	def initialize(id:,information:)
		self.ID = id
		data = information.split(",")
		self.initials = data[0]
		if data[1].include?("https:\/\/github") then 
			self.git = data[1]
			self.contact = data[2]
		else
			self.contact=data[1]
		end
	end
	def self.initialization(student)
		raise "require class's object Student" if(student.class!=Student)
		Student_short.new(id:student.ID,information:student.getInfo())
	end

	def read_from_txt(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		students = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				 students.push(Student.initialization(line.delete "\n")) if(line!="")
			end
		end
		students
	end

	def write_to_txt(addressFile,nameFile,students)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		students.each do |i|
			file.print("#{i.to_s()},#{i.get_all_contacts()},#{i.git}\n")
		end
		file.close
	end
private
	attr_writer :ID, :initials, :git, :contact
end