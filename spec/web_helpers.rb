def sign_up(username: 'testuser')
  visit '/users/new'
  fill_in 'username', with: username
  click_on 'submit'
end

def sign_in(username: 'testuser')
  visit '/users/signin'
  fill_in 'username', with: username
  click_on 'sign-in'
end

def make_post(test_content)
  fill_in 'postinfo', with: test_content
  click_on 'post'
end
