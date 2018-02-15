require_relative '../../app/models/post'
require_relative '../../app/models/user'
feature('SQL injection') do
  scenario('malicious entity tries to edit database') do
  	sign_up()
  	sign_in()
  	visit '/posts'
  	make_post("HACK', 1); truncate table posts; --")
  	expect(Post.all.empty?).to eq false
  end
end

feature('XSS attack') do
  scenario('A user cannot input a malicious post that displays browser alerts') do
    sign_up
    make_post('<script>window.alert("Hello world")</script>')
    sleep(1)
    visit '/posts'
    expect { page.driver.browser.switch_to.alert }.to raise_error
  end
end

feature('directory traversal') do
  scenario("malicious entity tries to access files that shouldn't be public") do
  	visit('/app')
  	expect(page).to have_content '404'
  end
  scenario('malicious entity tries to access files outside server') do
  	socket = TCPSocket.new('localhost', 3001)
  	socket.print "Get /../../\r\n"
  	response =socket.recv(4096)
  	expect(response).to have_content '404'
  end
end

feature('password encryption') do
  scenario('passwords are not stored in database') do
    sign_up()
    expect(User.find_first('username' => 'testuser').password).not_to eq('password')
  end
end

feature 'Cookie Manipulation' do
  scenario 'cookies cannot be hijacked (via simple javascript manipulation)' do
    sign_up(username: 'victim')
    id = User.find_first('username' => 'victim').id
    click_link 'Sign Out'
    sign_up(username: 'hijacker')
    page.execute_script("document.cookie = 'user-id=#{id}'")
    make_post('Hijacked')
    expect(page).to_not have_content 'victim'
  end
end

feature('authtoken encryption') do
  scenario('Original authentication keys are not stored in the database') do
    sign_up()
    user = User.find_first('username' => 'testuser')
    authkey = page.driver.browser.manage.cookie_named('user-id')[:value].split('-', 2)[0]
    expect(user.authhash).not_to eq(authkey)
  end
end
