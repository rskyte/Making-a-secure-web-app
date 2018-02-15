ENV['DB_ENV'] ||= 'development'
require 'socket'
require_relative 'lib/server/request'
require 'pp'
require_relative 'lib/db/db-connect'
require_relative 'lib/server/middleware'

class Server

  attr_reader :middleware

  def initialize(port = 3000, app_class)
    @server = TCPServer.new(port)
    @middleware = Middleware.new(app_class)
  end

  def run
    puts "Booting up the server.."
    puts "Server booted!"
    while(true) do
      Thread.start(@server.accept) do |socket|
        begin
          request = Request.new(socket.recv(4096))
          # pp request
          request.generate_hashes
          p request.get_cookie('user-id')
          # resource = request.get_location
          res = middleware.get_response(request)
          socket.print(res.build)
          socket.close
        rescue Exception => error
          puts "Error: " + error.to_s
          puts error.backtrace
          socket.print middleware.error.build
          socket.close
        end
      end
    end
  end

  private

end

Server.new(App).run if "server.rb" == $0
