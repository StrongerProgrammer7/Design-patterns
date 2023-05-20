
require 'fox16'

include Fox

class Modal_Window < FXDialogBox
	attr_writer :controller

	def initialize(app,name_modal,width:300,height:200)
		super(app, name_modal, :width => width, :height => height)
		@app = app
	
	end

	def addTimeoutCheck(data:nil)
		if(self.shown?) then
			@timeout_id = @app.addTimeout(200, :repeat => true) do
				if require_field_to_fill() then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end
	end

	private

	attr_reader :controller

	def create_close_button(horizontal_frame)
		close_button = FXButton.new(horizontal_frame, "Close", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		close_button.connect(SEL_COMMAND) do |sender, selector, data|
			removeTimeout(@timeout_id,@app)
			self.hide
		end
		close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	end

	def create_inputs(matrix)
		@name = create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname))
		@surname = create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname))
		@lastname = create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname))
		@phone = create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone))
		@mail = create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail))
	end

	def removeTimeout(timerId,app)
		app.removeTimeout(timerId)
	end

	def message_warning(text)
		FXMessageBox.warning(self,
			MBOX_OK,
			"Warning",
			text)
	end


	def check_letter(elem)
		elem.match?(/^[A-zА-яЁё\s]+$/) 
	end

	def check_phone(elem)
		elem.match?(/^\+?[0-9]*$/)
	end

	def check_let_dig_specilSymbol(elem)
		elem.match?(/\w+|[@]|[\.]|[:]|[\\]/)
	end

	def validate_surname_name_lastname(text)
		text.match?(/^[A-ZА-Я]([a-z]+|[a-яё]+)$/)
	end

	def valid_phone(text)
		text.match?(/^(\+7|8)[0-9]{9,15}$$/)
	end

	def valid_mail(text)
		text.match?(/^\w+[@][a-z]+[\.][a-z]{2,20}/)
	end
end