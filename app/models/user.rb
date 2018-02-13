require_relative '../../lib/db/db-model'
require_relative '../../lib/enc'

class User
  include DBModel, Enc
  extend Enc
  attr_reader :id
  attr_accessor :username, :password, :authhash

  def initialize(params)
    @id = params["id"]
    @username = params["username"]
    @password = params["password"]
  end

  def self.create(params)
  	params["password"] = enc(params["password"])
  	super(params)
  end

  def authorize(password)
  	return @password == enc(password)
  end

end
