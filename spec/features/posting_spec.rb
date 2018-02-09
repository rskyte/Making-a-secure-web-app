feature "Posting" do

  scenario "posts display" do
		sign_up()
		sign_in()
		visit '/posts'
		make_post('testing')
		expect(page).to have_content 'testing'
	end

end
