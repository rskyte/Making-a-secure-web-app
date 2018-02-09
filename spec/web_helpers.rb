def sign_up(username: 'testuser', password: 'password')
  visit '/users/new'
  fill_in 'username', with: username
  fill_in 'password', with: password
  fill_in 'password-conf', with: password
  click_on 'submit'
end

def sign_in(username: 'testuser', password: 'password')
  visit '/users/signin'
  fill_in 'username', with: username
  fill_in 'password', with: password
  click_on 'sign-in'
end

def make_post(test_content)
  fill_in 'postinfo', with: test_content
  click_on 'post'
end
