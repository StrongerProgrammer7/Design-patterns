require_relative File.dirname($0) + '/person.rb'

class Guard < Person
	attr_reader :exp_year
	def initialize(id:,surname:,name:,lastname:, phone:,exp_year:,mail:nil)
		super(surname:surname,name:name,lastname:lastname,phone:phone,mail:mail)
		self.exp_year = exp_year
		self.id = id
	end

	def Guard.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 4 || information.count(",") > 8)
		hash_data = Guard.string_to_hash(information.delete(' ').split(","))
		Guard.new(id:hash_data["id"],surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"],exp_year:hash_data["exp"])
	end

	def set_information(surname:nil,name:nil,lastname:nil, phone:nil,mail:nil,exp_year:nil)
		super(surname:surname,name:name,lastname:lastname,phone:phone,mail:mail)
		self.exp_year = exp_year if exp_year!=nil and exp_year != '' 
	end
	
	def to_s()
		"#{self.surname} #{self.name} #{self.exp_year}"
	end
	
	private
		attr_writer :exp_year
		
		define_singleton_method :check_exp_count_year do |count_year|
			/^[0-9]{1,2}$/.match(count_year)
		end

		def self.string_to_hash(data)
			num = if (Person.check_word(data[3]) == nil) then 3 else 4 end
			hash_data = Hash.new
			hash_data["id"] = data[0]
			hash_data["surname"] = data[1]
			hash_data["name"]=data[2]
			hash_data["lastname"] = if num == 4 then data[3] else nil end
			data.drop(num).each do |i|
				next if(i==nil)
				hash_data["mail"] = i if(Person.check_mail(i)!=nil) 
				hash_data["phone"] = i if(Person.check_phone(i)!=nil)
				hash_data["exp"] = Integer(i) if (Guard.check_exp_count_year(i)!=nil)
			end
			return hash_data
		end
end

