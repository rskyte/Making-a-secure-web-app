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
    login user, redirect('/posts') if user
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
    login user, redirect('/posts')
  end

  def get_users_signout request
    p current_user(request)
    redirect('/users/signin', "user-id=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT")
  end

  private
  def redirect(path, cookie = nil)
    params = {location: path, code: "303 See Other"}
    params[:cookie] = cookie if cookie
    params
  end

  def login user, params
    p user
    params[:cookie] = "user-id=#{user.id}; path=/"
    params
  end

  def current_user request
    user = User.find_first({"id" => request.get_cookie("user-id")}) if request.has_cookie?
  end
end
