feature 'Posting' do
  scenario 'posts display' do
		sign_up()
		sign_in()
		visit '/posts'
		make_post('testing')
    sleep(1)
		expect(page).to have_content 'testing'
	end

  scenario 'post page shows which user is logged in' do
    sign_up()
    sign_in()
    visit '/posts'
    expect(page).to have_content 'Signed in as testuser'
  end
end
