require_relative "../../lib/enc"
include Enc

describe "#generate_auth_token" do 
  it "should return a 20 character authentication key" do
  	expect(generate_auth_token.length).to eq 20
  end
  # impossible to perfectly test for randomness, this is the best we got
  it "should be random" do
  	srand(1)
  	
  	twenty_tokens = Array.new(20){generate_auth_token}
  	expect(twenty_tokens.uniq.length).to eq 20

  	expect(self).to receive(:rand).at_least(:once).and_return(5)
  	generate_auth_token
  end
end