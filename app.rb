require_relative './lib/user'
require_relative './lib/templating_engine'

class App
  include TemplatingEngine

  def get_homepage request
    username = current_user(request).username if current_user(request)
    "Welcome #{username}"
  end

  def get_users request
    "Hello World!"
  end

  def get_users_new request
    File.read("public/sign-up.html")
  end

  def get_users_signin request
    File.read("public/sign-in.html")
  end

  def post_login request
    user = User.find("username" => request.get_param("username"))
    login user, redirect('/') if user
  end

  def get_posts request
    unless request.has_cookie?
      return redirect('/users/signin')
    end
    @username = current_user(request).username if current_user(request)
    herb('public/posts.html')
  end

  def post_users request
    user = User.create("username" => request.get_param("username"))
    login user, redirect('/')
  end

  private
  def redirect path
    {location: path, code: "303 See Other"}
  end

  def login user, params
    params[:cookie] = "user-id=#{user.id}"
    params
  end

  def current_user request
    user = User.find_first({"id" => request.get_cookie("user-id")}) if request.has_cookie?
  end
end
