
require 'fox16'
require 'clipboard'
require 'date'

include Fox

class Modal_create_lab < FXDialogBox

	def initialize(app,controller)
		@app = app
		@student_list_controller = controller
		
		super(app, "Add lab", :width => 800, :height => 700)
		
		@lab_field = {"name" =>nil,"topics" => nil, "tasks" => nil,
			"date_of_issue" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@number = create_textField(matrix,"Number",nil,nil)
		@name = create_textField(matrix,"Name",method(:check_letter),method(:validate_name))
		@topics = create_text(matrix,"Topics",method(:check_let_dig_specilSymbol),method(:validate_topics))
		@tasks = create_text(matrix,"Tasks",method(:check_let_dig_specilSymbol),method(:validate_tasks))
		@date = create_textField(matrix,"date_of_issue",method(:check_date),method(:valid_date))
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck(data:nil)
		@data = data if data.length != 0
		if(self.shown?) then
			@timeout_id = @app.addTimeout(500, :repeat => true) do
				if @lab_field["name"]!=nil && @lab_field["date_of_issue"] != nil then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end
		#print @data[@data.length-1][0],"\n"
		@number.setText((@data[@data.length-1][0] + 1).to_s) if data.length != 0
		@number.setText(1.to_s) if  data.length == 0
	end

private
	def create_close_button(horizontal_frame)
		close_button = FXButton.new(horizontal_frame, "Close", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		close_button.connect(SEL_COMMAND) do |sender, selector, data|
			@app.removeTimeout(@timeout_id)
			clear_inputs()
			self.hide
		end
		close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	end

	def create_button_ok(horizontal_frame)
		ok_button = FXButton.new(horizontal_frame, "Ok", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		ok_button.disable
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			#TODO:Validate special field	
			date_last_lab = @data[@data.length-1][4].to_s if @data[@data.length-1][4] !=nil
			date_current = @lab_field["date_of_issue"].to_s
			date_last_lab = Date.strptime(date_last_lab, '%d.%m.%Y').strftime('%Q').to_i if date_last_lab !=nil
			date_current = Date.strptime(date_current, '%d.%m.%Y').strftime('%Q').to_i
			if date_last_lab!= nil && ((date_current > date_last_lab) ||  @number.text.to_i == 1) then
				@lab_field["number"] = @number.text.to_i
				@student_list_controller.create_entity(@lab_field)
				@app.removeTimeout(@timeout_id)
				clear_inputs()
				self.hide
			else				FXMessageBox.warning(self,MBOX_OK,"Warning",
					"Вы не можете выдать эту лабораторную работу раньше предыдущей.\nСрок выдачи ЛР №#{(@number.text.to_i-1).to_s} - <#{@data[@data.length-1][4].to_s}>")
			end


			
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 80)
    	if(name != "Number") then
    		nameField.connect(SEL_VERIFY) do |sender, sel, tentative|
    			if method_check.call(tentative)
    				false 
    			else		
    				true
    			end
    		end
    		nameField.connect(SEL_CHANGED) do 
    			validate_field(nameField,method_validate,name)
    		end
    	else
    		nameField.disable
    	end
    	nameField
	end
	def create_text(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	#nameField = FXTextField.new(frame, 20)
    	nameField = FXText.new(frame, nil, 0, TEXT_WORDWRAP|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT)

    	nameField.height = 250

    	nameField.connect(SEL_VERIFY) do |sender, sel, tentative|
    		if method_check.call(tentative)
    			false 
    		else		
    			true
    		end
    	end
    	nameField.connect(SEL_CHANGED) do 
    		validate_field(nameField,method_validate,name)
    	end
    	nameField
	end



	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@lab_field[name.downcase] = nameField.text 
        else 
        	@lab_field[name.downcase] = nil 
        end
	end

	def clear_inputs()
		@name.setText('')
		@tasks.setText('')
		@topics.setText('')
		@date.setText('')
	end


	def check_letter(elem)
		elem.match?(/^[A-zА-яЁё\s]+$/) 
	end

	def check_date(elem)
		elem.match?(/^[0-9\.]+$/)
	end

	def check_let_dig_specilSymbol(elem)
		elem.match?(/\w+|[\.]|[\\]|\s|[#]|[\^]|[\&]|[\*]|[\[]|[\]]|[\(]|[\)]|[\{]|[\}]/)
	end

	def validate_name(text)
		text.match?(/^[A-ZА-Я]((([a-z]+|[a-яё]+)\s*){2,99})$/)
	end

	def validate_topics(text)
		text.match?(/\A[\d\/]*[A-z\w\b\s\d\"\:\.\?\!\,\&\-\']{1,999}\z/)
	end

	def validate_tasks(text)
		text.match?(/\A[\d\/[A-z]\,]*[A-z\w\b\s\d\"\:\.\?\!\(\)\{\}\[\]\,\-\'\&']{1,9999}\z/)
	end

	def valid_date(text)
		text.match?(/^(0[1-9]|[1|2][0-9]|3[01])\.(0[1-9]|1[0-2])\.(\d{2}|\d{4})$/)
	end

end

=begin

Here are some article titles related to multiple tasks:

1. "Managing Multiple Tasks: Tips for Boosting Your Productivity"
2. "The Art of Juggling Multiple Tasks: How to Stay Focused and Organized"
3. "Mastering Multitasking: How to Handle Multiple Tasks Without Losing Your Mind"
4. "The Benefits and Pitfalls of Tackling Multiple Tasks at Once"
5. "How to Prioritize and Manage Multiple Tasks Effectively"
6. "The Power of Multitasking: Tips for Successfully Handling Multiple Tasks"
7. "Multitasking vs. Single Tasking: Which Is Better for Productivity?"
8. "Overcoming Overwhelm: Strategies for Tackling Multiple Tasks and Projects"
9. "The Science of Multitasking: How Our Brains Handle Multiple Tasks"
10. "Multitasking Myths: Separating Fact from Fiction When It Comes to Handling Multiple Tasks"

1. Create a login system using Ruby on Rails
2. Develop a chat application using Node.js and Socket.io
3. Build a weather application using React and OpenWeatherMap API
4. Implement a CRUD (Create, Read, Update, Delete) functionality in a web application using Django framework
5. Create a RESTful API using Laravel framework
6. Develop a mobile application using Flutter framework
7. Build a recommendation system using machine learning algorithms in Python
8. Implement an e-commerce website using WooCommerce plugin in WordPress
9. Create a game using Unity game engine
10. Develop a social media platform using Ruby on Rails

=end
