class Laboratory_work
	attr_reader :number,:name, :topics, :tasks ,:date
	attr_accessor :id

	define_singleton_method :check_word do |word|
		/^[A-ZА-Я]((([a-z]+|[a-яё]+)\s*){2,99})$/.match(word)
	end

	define_singleton_method :check_date do |date|
		/^((\d{2}|\d{4})[\.|\-](0[1-9]|1[0-2])[\.|\-](0[1-9]|[1|2][0-9]|3[01])|(0[1-9]|[1|2][0-9]|3[01])[\.|\-](0[1-9]|1[0-2])[\.\-](\d{2}|\d{4}))$/.match(date)
	end


	def initialize(id:,number:,name:,topics:nil,tasks:nil,date:)
		set_baseInfo(name:name,date:date)
		set_extraInfo(topics:topics,tasks:tasks) 
		self.id = id
		self.number = number
	end

	def self.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 3 || information.count(",") > 6)
		hash_data = Laboratory_work.stringInformation_to_hash(information.delete(' ').split(","))
		Laboratory_work.new(id:hash_data["id"],number:hash_data["number"],name:hash_data["name"],topics:hash_data["topics"],tasks:hash_data["tasks"],
			date:hash_data["date"])
	end

	def to_s()
		"#{self.name} #{self.topics} #{self.date}"
	end
	def set_baseInfo(name:,date:)
		valid_baseField_onCorrect(name:name,date:date)
		self.name = name if(name!=nil)
		
		self.date = date if(date !=nil)
	end

	def set_extraInfo(topics:,tasks:)
		valid_extraField_onCorrect(topics:topics,tasks:tasks)		
		self.tasks = tasks if(topics != nil)
		self.topics = topics if(topics != nil)
	end
		
	private
		@@number = 0
		attr_writer :number, :name, :topics, :tasks ,:date

		def self.stringInformation_to_hash(data)
			hash_data = Hash.new
			hash_data["id"] = data[0]
			hash_data["number"] = data[1]	,
			hash_data["name"] = data[2]	
			hash_data["topics"] = data[3]
			hash_data["tasks"] = data[4]
			hash_data["date"] = data[5]
			hash_data
		end

		def valid_baseField_onCorrect(name:,date:)
			if(name!=nil) then
				raise "Not valid name [A-Z][a-z]+ #{name}"  if(Laboratory_work.check_word(name) == nil || name.length > 99)
			end
			if(date!=nil) then
				raise "Not valid date #{date}"  if(Laboratory_work.check_date(date) == nil)
			end
		end

		def valid_extraField_onCorrect(topics:,tasks:)
			if(topics!=nil) then
				raise "Not valid topics [A-Z][a-z]+ #{topics}"  if(topics.length > 999)
			end
			if(tasks!=nil) then
				raise "Not valid tasks [A-Z][a-z]+ #{tasks}"  if(tasks.length > 9999)
			end	
		end

end