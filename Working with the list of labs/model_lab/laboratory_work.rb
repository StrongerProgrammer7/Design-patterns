class Laboratory_work
	attr_reader :number,:name, :topics, :tasks ,:date
	attr_accessor :id

	define_singleton_method :check_word do |word|
		/^[A-ZА-Я]([a-z]+|[a-яё]+)$/.match(word)
	end

	define_singleton_method :check_date do |date|
		/^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.(19|20)\d\d$/.match(date)
	end

	def initialize(id:,name:,topics:,tasks:nil,date:)
		set_baseInfo(name:name,topics:topics,date:date)
		set_extraInfo(tasks:tasks) if tasks!=nil
		@@number +=1
		self.number = @@number + 1
		self.id = id
	end

	def to_s()
		"#{self.name} #{self.topics} #{self.date}"
	end
	def set_baseInfo(name:,topics:,date:)
		valid_baseField_onCorrect(name:name,topics:topics,date:date)
		self.name = name if(name!=nil)
		self.topics = topics if(topics != nil)
		self.date = date if(date !=nil)
	end

	def set_extraInfo(tasks:nil)
		valid_extraField_onCorrect(tasks:tasks)		
		self.tasks = tasks 
	end
		
	private
		@@number = 0
		attr_writer :number, :name, :topics, :tasks ,:date

		def valid_baseField_onCorrect(name:,topics:,date:)
			if(name!=nil) then
				raise "Not valid surname [A-Z][a-z]+ #{name}"  if(Laboratory_work.check_word(name) == nil || name.length > 99)
			end
			if(topics!=nil) then
				raise "Not valid name [A-Z][a-z]+ #{topics}"  if(Laboratory_work.check_word(topics) == nil || topics.length > 999)
			end
			if(date!=nil) then
				raise "Not valid lastname [A-Z][a-z]+ #{date}"  if(Laboratory_work.check_date(date) == nil)
			end
		end

		def valid_extraField_onCorrect(tasks:)
			if(tasks!=nil) then
				raise "Not valid tasks [A-Z][a-z]+ #{name}"  if(tasks.length > 9999)
			end	
		end

end