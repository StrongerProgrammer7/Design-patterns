require_relative File.dirname($0) + '/../decorator.rb'

class Mark_decorator < Decorator

	def initialize(filter,component)
		query = make_query(filter)
		super(component,component.query_select + query)
	end

	def make_query(filter)
		filter = '' if filter == nil
		return " AND (Model.mark LIKE '%#{filter}%')"
	end
end