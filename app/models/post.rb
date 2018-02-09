require_relative '../../lib/db/db-model'

class Post
  include DBModel
  attr_reader :id
  attr_accessor :content, :user_id
  def initialize(params)
    @id = params["id"]
    @content = params["content"]
    @user_id = params["user_id"]
  end

end
