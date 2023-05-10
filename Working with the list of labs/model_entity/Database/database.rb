require 'mysql2'
include Mysql2

class Students_DB

	def self.getInstance()
		if @@mysql.nil?
			@@mysql = Mysql2::Client.new(:username => 'alex', :host => 'localhost')
			@@mysql.query("USE Students")
		end
		if @@inst.nil?
			@@inst = Students_DB.new()
		end
		@@inst	
	end
			
	def crud_student_by_db(query)
		begin
			@@mysql.query(query)
		rescue Mysql2::Error => e
			print e
		end
	end

	private 
		@@mysql = nil 
		@@inst = nil
	
end
