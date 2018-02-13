module TemplatingEngine

	def herb(file)
		text = File.read file
		text = convert text
		execute text
	end

	private

	def convert string
		("output = \"" + string.gsub("\"","'"))
			.delete("\n")
			.gsub("~%=", "\"\noutput +=")
		  .gsub("~%", "\"\n")
		  .gsub("%~", "\noutput += \"")
		  .+ "\"\nreturn output"
	end

	def execute string
		p string
		eval(string)
	end

end
