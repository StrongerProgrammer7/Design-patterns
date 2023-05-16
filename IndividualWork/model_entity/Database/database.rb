require 'mysql2'
include Mysql2

class Parking_DB

	def self.getInstance()
		if @@mysql.nil?
			@@mysql = Mysql2::Client.new(:username => 'alex', :host => 'localhost')
			@@mysql.query("USE Parking")
		end
		if @@inst.nil?
			@@inst = Parking_DB.new()
		end
		@@inst	
	end
			
	def crud_by_db(query)
		begin
			@@mysql.query(query)
		rescue Mysql2::Error => e
			print e
			[]
		ensure
			if !@@mysql.ping then
				@@mysql.close
				print "connection close\n"
			end
		end
	end

	private 
		@@mysql = nil 
		@@inst = nil
	
end
