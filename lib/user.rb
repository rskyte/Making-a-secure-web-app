require_relative 'db-model'

class User
  include DBModel
  attr_reader :id
  attr_accessor :username, :password
  
  def initialize(params)
    @id = params["id"]
    @username = params["username"]
    @password = params["password"]
  end

end
