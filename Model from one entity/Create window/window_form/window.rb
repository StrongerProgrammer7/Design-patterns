require 'fox16'
include Fox

=begin
application = FXApp.new("Hi","Ruby")
main = FXMainWindow.new(application,"Hi",nil,nil,DECOR_ALL)
application.create()
main.show(PLACEMENT_SCREEN)
application.run()
=end

class Student_window < FXMainWindow
	def initialize(app)
		super(app,"Students",:width=>1000,:height=>600)
		FXLabel.new(self,"Student base", :opts=>LAYOUT_EXPLICIT, :width=>100, :height=>30, :x=>400, :y=>2)
		FXLabel.new(self,"Student table", :opts=>LAYOUT_EXPLICIT, :width=>150, :height=>30, :x=>350, :y=>55)
	end
	
	def create
		super
		show(PLACEMENT_SCREEN)
	end
end

app = FXApp.new
Student_window.new(app)
app.create
app.run