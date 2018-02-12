module Enc

	def enc inputstring
	  num = inputstring.unpack("b100")[0].to_i(2)
	  srand(num)
	  nu = rand( (16 ** 1024))
	  hex = nu.to_s(9)
	  hex.scan(/../).map { |hexchr|
	  	chr = (hexchr.to_i(9)+33).chr
	  	chr = "u" if chr == "'"
	  	chr
	  }.join
	end

end