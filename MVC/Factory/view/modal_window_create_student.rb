
require 'fox16'
require 'clipboard'

include Fox

class Modal_create_student < FXDialogBox
	attr_writer :student_list_controller

	def initialize(app)
		@app = app
		#@student_list_controller = controller
		
		super(app, "Add student", :width => 300, :height => 300)
		
		@student_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "telegram" => nil, "git" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname))
		create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname))
		create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname))
		create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone))
		create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail))
		create_textField(matrix,"Telegram",method(:check_let_dig_specilSymbol),method(:valid_mail))
		create_textField(matrix,"Git",method(:check_let_dig_specilSymbol),method(:valid_mail))
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck()
		if(self.shown?) then
			@timeout_id = @app.addTimeout(500, :repeat => true) do
				if @student_field["surname"]!=nil && @student_field["name"] != nil then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end
	end

private
	attr_reader :student_list_controller
	def create_close_button(horizontal_frame)
		close_button = FXButton.new(horizontal_frame, "Close", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		close_button.connect(SEL_COMMAND) do |sender, selector, data|
			@app.removeTimeout(@timeout_id)
			self.hide
		end
		close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	end

	def create_button_ok(horizontal_frame)
		ok_button = FXButton.new(horizontal_frame, "Ok", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		ok_button.disable
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			#TODO:Validate special field
			@app.removeTimeout(@timeout_id)
			@student_list_controller.create_student(@student_field)
			self.hide
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 20)
    	nameField.text = name if name == "Name" || name == "Surname" || name == "Lastname"

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

    	
	end

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@student_field[name.downcase] = nameField.text 
        else 
        	@student_field[name.downcase] = nil 
        end
	end


	def check_letter(elem)
		elem.match?(/^[A-zА-яЁё\s]+$/) 
	end

	def check_phone(elem)
		elem.match?(/^[0-9\+]+$/)
	end

	def check_let_dig_specilSymbol(elem)
		elem.match?(/\w+|[@]|[\.]|[:]|[\\]/)
	end


	def validate_surname_name_lastname(text)
		text.match?(/^[A-ZА-Я]([a-z]+|[a-яё]+)$/)
	end

	def valid_phone(text)
		text.match?(/^[0-9\+]{8,15}$/)
	end

	def valid_mail(text)
		text.match?(/^\w+[@][a-z]+[\.][a-z]{2,20}/)
	end

	def valid_git(text)
		text.match?(/^https:\/\/github\.com\/[A-z0-9]*\/[A-z0-9]*\.git/)
	end

	def valid_telegram(text)
		text.match?(/^@[A-z0-9]*/)
	end


end

