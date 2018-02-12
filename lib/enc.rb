module enc

	def enc inputstring
	  num = inputstring.unpack("b100")[0].to_i(2)
	  srand(num)
	  nu = rand( (2 ** 256))
	  hex = nu.to_s(2)
	  hex.scan(/......./).map { |hexchr|
	  	hexchr.to_i(2).chr
	  }.join
	end

end