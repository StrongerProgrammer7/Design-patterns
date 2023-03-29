load './person.rb'

class Student < Person
	def initialize(surname:,name:,lastname:, phone:nil, telegram:nil,mail:nil,git:nil)
		super(surname:surname,name:name,lastname:lastname)
		set_information(phone:phone,mail:mail,telegram:telegram,git:git)
		self.id = @@countStudent
		@@countStudent = @@countStudent + 1
	end

	def Student.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 2 || information.count(",") > 7)
		hash_data = Student.stringInformation_to_hash(information.delete(' ').split(","))
		Student.new(surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"],telegram:hash_data["telegram"],git:hash_data["git"])
	end

	def set_information(surname:nil,name:nil,lastname:nil, phone:nil,mail:nil,telegram:nil,git:nil)
		set_baseInfo(surname:surname,name:name,lastname:lastname)
		set_extraInfo(phone:phone,mail:mail,telegram:telegram,git:git)
	end

	def getInfo()
		"#{getSurname_Initials()} #{getGit()} #{getAnyContact()}"
	end

	private
		@@countStudent = 8536

		def self.stringInformation_to_hash(data)
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
	
		protected def getAnyContact()
			return ",phone => #{self.phone} " if(self.phone!=nil)
			return ",mail => #{self.mail} " if(self.mail !=nil)
			return ",telegram => #{self.telegram} " if(self.telegram!=nil)
			return ",have't contact" 
		end

end

