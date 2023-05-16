require_relative File.dirname($0) + '/../decorator.rb'

class Mail_decorator < Decorator

	def initialize(filter,component)
		query = make_query(filter)
		super(component,component.query_select + query)
	end

	def make_query(filter)
		if filter != nil and filter.include? "NULL"
			return  "AND (mail IS NULL OR mail = 'NULL') "
		elsif filter == nil
			return ""
		else
			return "AND (mail LIKE '%#{filter}%' AND mail IS NOT NULL AND mail != 'NULL')"
		end
	end
end