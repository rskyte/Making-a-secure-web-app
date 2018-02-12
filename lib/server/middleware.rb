require_relative '../../app/app.rb'
require_relative 'response'

class Middleware
  ErrorResponse = "I'm an error. Apparently the server didn't like your request and threw me!"

  def initialize(app_class, response_class = Response)
    @app = app_class.new
    @parameters = Hash.new
    @response_class = response_class
  end

  def get_response request
    params =get_response_params(build_controller_name(request), request)

    response_class.new(params)
  end

  def error
     params = {code: "500 Internal Server Error", text: ErrorResponse }
     response_class.new(params)
  end

  private

  attr_reader :response_class, :parameters, :app

  def clean()
    parameters = Hash.new
  end

  def build_controller_name(request)
    method = request.get_method
    location = request.get_location.split("/").join("_")
    location = "_homepage" if location.empty?
    controller_name =  "#{method}#{location}".downcase
  end

  def error404()
    {text: "<h1>404 Error</h1><br>Page not found", code: "404 Not Found"}
  end

  def get_response_params(method, request)
    if app.respond_to?(method)
     res = app.public_send(method, request)
     return (res.is_a? Hash) ? res : {text: res}
    else
     try_find_resource(request.get_location)
    end
  end

  def list_directory(dir=".")
    dir = '.' if dir == ''
    p dir
    list = Dir.entries(dir).sort
    newlist = []
    list.each { |item| newlist << "<a href=/#{dir}/#{item}>#{item}</a>"}
    newlist.join("<br>")
  end

  def try_find_resource(resource)
    resource = resource.sub(/^\/+/, "")
    return error404 unless validate_resource_path(resource)
    is_dir = File.directory?(resource)
    if is_dir || resource == ''
      return {text: list_directory(resource)}
    else
      return File.file?(resource) ? {text: File.read(resource)} : error404
    end
  end

  def validate_resource_path(resource)
    resource.start_with?("public") && !resource.include?("..")
  end

end
