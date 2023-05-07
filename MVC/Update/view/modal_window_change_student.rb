
require 'fox16'
require 'clipboard'

include Fox

class Modal_change_student < FXDialogBox

	def initialize(app,controller)
		@app = app
		@student_list_controller = controller
		
		super(app, "Add student", :width => 400, :height => 250)
		
		@student_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "telegram" => nil, "git" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@name = create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname))
		@surname = create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname))
		@lastname = create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname))
		@phone = create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone))
		@mail = create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail))
		@telegram = create_textField(matrix,"Telegram",method(:check_let_dig_specilSymbol),method(:valid_mail))
		@git = create_textField(matrix,"Git",method(:check_let_dig_specilSymbol),method(:valid_mail))
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck()
		if(self.shown?) then
			@timeout_id = @app.addTimeout(2000, :repeat => true) do
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
		@current_id = id
		@student_data = @student_list_controller.get_student_by_id(@current_id)
		fill_inputs(@name,"Name")
		fill_inputs(@surname,"Surname")
		fill_inputs(@lastname,"Lastname")
		fill_inputs(@phone,"phone")
		fill_inputs(@mail,"mail")
		fill_inputs(@telegram,"telegram")
		fill_inputs(@git,"git")
	end

private
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
			#@student_list_controller.create_student(@student_field)
			self.hide
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 30)
    	
    	nameField.disable if name=="Phone" || name=="Telegram" || name=="Git" || name=="Mail"
    	

    	nameField.connect(SEL_KEYPRESS) do |sender, sel, event|
    		if method_check.call(event.text)  && event.code != KEY_Tab && event.code != KEY_Return && event.code != KEY_KP_Enter then
    			curpos = nameField.cursorPos 
    			nameField.text = nameField.text.slice(0, nameField.cursorPos) + event.text + nameField.text.slice(nameField.cursorPos, nameField.text.length)
    			nameField.setCursorPos(curpos+1)
    		end
        	action_operation_toTextField(event,nameField)
        	if method_validate.call(nameField.text) then 
        		@student_field[name.downcase]=nameField.text 
        	else @student_field[name.downcase] =nil 
        	end
        #print nameField.text
    	end
    	nameField
	end

	def fill_inputs(nameField,name)
		nameField.setText(@student_data[0]["#{name}"]) 
	end



	def action_operation_toTextField(event,nameField)
		if event.code == KEY_BackSpace && nameField.text[nameField.cursorPos-2] != nil then
			#nameField.setText(nameField.text[0..-2]) 
			action_delete(nameField,nameField.cursorPos-1,nameField.cursorPos,1) if nameField.cursorPos !=0
		end
		if event.code == KEY_Delete && nameField.text[nameField.cursorPos] != nil then
			action_delete(nameField,nameField.cursorPos,nameField.cursorPos+1,0)
    	end
    	nameField.setCursorPos(nameField.cursorPos - 1) if nameField.cursorPos > 0 && event.code == KEY_Left
    	nameField.setCursorPos(nameField.cursorPos + 1) if nameField.cursorPos <= nameField.text.length && event.code == KEY_Right
   
    	if (event.state & CONTROLMASK) && event.code == KEY_V
        	text = Clipboard.paste
        	nameField.setText(text)
    	end

	end

	def action_delete(nameField,prev_cur,next_cur,margin)
		curpos = nameField.cursorPos 
		nameField.text = nameField.text.slice(0, prev_cur) + nameField.text.slice(next_cur, nameField.text.length)
		nameField.setCursorPos(curpos-margin)
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

