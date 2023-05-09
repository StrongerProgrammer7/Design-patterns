
require 'fox16'
require 'clipboard'

include Fox

class Modal_change_student < FXDialogBox
	attr_writer :student_list_controller

	def initialize(app)
		@app = app
		#@student_list_controller = controller
		
		super(app, "Change student", :width => 400, :height => 250)
		
		@student_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "telegram" => nil, "git" => nil, "id" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@name = create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname))
		@surname = create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname))
		@lastname = create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname))
		@phone = create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone))
		@mail = create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail))
		@telegram = create_textField(matrix,"Telegram",method(:check_let_dig_specilSymbol),method(:valid_mail))
		@git = create_textField(matrix,"Git",method(:check_let_dig_specilSymbol),method(:valid_mail))
	
		@fields = {"Name"=>@name,"Surname"=>@surname,"Lastname" =>@lastname,
			"phone" => @phone, "telegram" => @telegram, "git" => @git,"mail" => @mail}
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck()
		if(self.shown?) then
			@timeout_id = @app.addTimeout(1000, :repeat => true) do
				if @student_field["surname"]!=nil && @student_field["name"] != nil then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end
	end

	def get_personal_data_student(id)
		@student_data = []
		@student_data = @student_list_controller.get_student_by_id(id)
		if(@student_data.class!=Student) then
			@student_data = @student_data
			@fields.each do |key,val|
				fill_inputs(val,key)
			end
		else
			fill_inputs_from_object()
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
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			#TODO:Validate special field
			@student_field["id"] = @student_data["Id"] if @student_data.class!=Student
			@student_list_controller.update_student(@student_field)
			@app.removeTimeout(@timeout_id)
			self.hide
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 30)
    	
    	nameField.disable if name=="Phone" || name=="Telegram" || name=="Git" || name=="Mail"

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

	def fill_inputs(nameField,name)
		nameField.text = @student_data["#{name}"] if @student_data["#{name}"] != nil
		@student_field["#{name.downcase}"] = @student_data["#{name}"] if @student_data["#{name}"] != nil
	end

	def fill_inputs_from_object()
		@name.text = @student_data.name if @student_data.name != nil
		@surname.text = @student_data.surname if @student_data.surname != nil
		@lastname.text = @student_data.lastname if @student_data.lastname != nil
		@phone.text = @student_data.phone if @student_data.phone != nil
		@mail.text = @student_data.mail if @student_data.mail != nil
		@git.text = @student_data.git if @student_data.git != nil
		@telegram.text = @student_data.telegram if @student_data.telegram != nil

		@student_field["name"] = @student_data.name if @student_data.name != nil
		@student_field["surname"] = @student_data.surname if @student_data.surname != nil
		@student_field["lastname"] = @student_data.lastname if @student_data.lastname != nil
		@student_field["phone"] = @student_data.phone if @student_data.phone != nil
		@student_field["mail"] = @student_data.mail if @student_data.mail != nil
		@student_field["git"] = @student_data.git if @student_data.git != nil
		@student_field["telegram"] = @student_data.telegram if @student_data.telegram != nil
		@student_field["id"] = @student_data.id
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

