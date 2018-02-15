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
    @authhash = params["authhash"]
  end

  def self.create(params)
  	params["password"] = enc(params["password"]) #comment me out to prevent password hashing
  	super(params)
  end

  def authorize(password)
  	return @password == enc(password) #comment me out to allow authentication if password hashing is off 
    return @password == password
  end

end
