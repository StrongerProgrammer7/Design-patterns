require_relative File.dirname($0) + '/../decorator.rb'

class Phone_decorator < Decorator

	def initialize(filter,component)
		query = make_query(filter)
		super(component,component.query_select + query)
	end

	def make_query(filter)
		filter = '' if filter == nil
		if((filter[0]=='8' && filter.length == 1)|| (filter[0]=='+' && filter.length == 2))
			return  " AND (phone LIKE '#{filter}%')"
		else
			return " AND (phone LIKE '%#{filter}%')"
		end
	end
end