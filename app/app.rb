require_relative 'models/user'
require_relative 'models/post'
require_relative '../lib/templating_engine'

class App
  include TemplatingEngine

  def get_homepage request
     redirect "/posts"
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

  def post_users_signin request
    request = process_request request
    user = User.find_first("username" => request.get_param("username"))
    if user.password == request.get_param("password") && user
      return login user, redirect('/posts')
    end
    redirect('/users/signin')
  end

  def get_posts request
    unless request.has_cookie?
      return redirect('/users/signin')
    end
    @username = current_user(request).username if current_user(request)
    @posts = Post.all.reverse
    herb('public/posts.html')
  end

  def get_allposts request
    Post.all.map{|post|{content: post.content,
                        user: User.find_first({'id' => post.user_id}).username} }
                        .to_json
  end

  def post_posts request
    request = process_request request
    post = Post.create("content" => request.get_param("post-content"),
                       "user_id" => current_user(request).id)
    redirect('/posts')
  end

  def post_users request
    request = process_request request
    if validate_password request
      user = User.create("username" => request.get_param("username"),
                         "password" => request.get_param("password"))
      return login user, redirect('/posts') if user
    end
    redirect('/users/new')
  end

  def get_users_signout request
    redirect('/users/signin',
             "user-id=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT")
  end

  private
  def process_request request
    request.params.each{ |k, v| request.params[k] = sanitize_user_input(v) }
    request
  end

  def sanitize_user_input input
    input.gsub(/['";<>]/, "'" => "&#39;",
                          '"' => "&#34;",
                          ";" => "&#59;",
                          "<" => "&#60;",
                          ">" => "&#62;")
  end

  def validate_password request
    (request.get_param("password") == request.get_param("password_conf")) && (request.get_param("password").length > 6)
  end

  def redirect(path, cookie = nil)
    params = {location: path, code: "303 See Other"}
    params[:cookie] = cookie if cookie
    params
  end

  def login user, params
    params[:cookie] = "user-id=#{user.id}; path=/"
    params
  end

  def current_user request
    User.find_first({"id" => request.get_cookie("user-id")}) if request.has_cookie?
  end
end
