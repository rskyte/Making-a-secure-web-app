module Enc

	HASHMAP = {
		"00" => ">",
		"01" => "<",
		"10" => "^",
		"11" => "v"
	}

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

	def generate_auth_token
		Array.new(20).map{(rand(96)+33).chr}.join
	end

	def cookie_enc input_int
		srand(input_int.to_i)
		nu = rand(2 ** 512)
		nu.to_s(2).scan(/../).map { |chr|
			HASHMAP[chr]
		}.join
	end

end
