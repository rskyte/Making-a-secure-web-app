require_relative '../../app/models/post'
require_relative '../../app/models/post'
feature("SQL injection") do
  scenario("malicious entity tries to edit database") do
  	sign_up()
	sign_in()
	visit '/posts'
	make_post("HACK',1); truncate table posts;--")
	expect(Post.all).not_to be :empty?
  end
end
feature("directory traversal") do
  scenario("malicious entity tries to access files that shouldn't be public") do
  	visit("/app")
  	expect(page).to have_content "404"
  end
  scenario("malicious entity tries to access files outside server") do
  	socket = TCPSocket.new('localhost', 3001)
  	socket.print "Get /../../\r\n"
  	response =socket.recv(4096)
  	expect(response).to have_content "404"
  end
end
feature("password encryption") do
  scenario("passwords are not stored in database") do
    sign_up()
    expect(User.find_first({"username" => "testuser"}).password).not_to eq("password")
  end
end
feature("authtoken encryption") do
  # scenario("user logs in and is given an auth token") do
  # 	srand(5)
  # 	sign_up
  # 	sign_in
  # 	auth_token_value = Capybara.current_session.driver.request.cookies.[]('auth_token')
  # 	expect(auth_token_value).to eq()
  # end


  scenario("authtokens are not stored in database") do
    sign_up()
    user =User.find_first({"username" => "testuser"})
    
    expect(user.authhash).not_to eq(token)
  end
end
