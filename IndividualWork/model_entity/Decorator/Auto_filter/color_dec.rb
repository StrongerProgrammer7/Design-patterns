require_relative File.dirname($0) + '/../decorator.rb'

class Color_decorator < Decorator

	def initialize(filter,component)
		query = make_query(filter)
		super(component,component.query_select + query)
	end

	def make_query(filter)
		filter = '' if filter == nil
		return " AND (color LIKE '%#{filter}%')"
	end
end