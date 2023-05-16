
require_relative '../entity_DB/entity_list_DB.rb'

class Decorator < Entities_list_DB

	attr_accessor :component

	def initialize(entity,query)
		super(query_select:query)
		self.component = entity
	end

end