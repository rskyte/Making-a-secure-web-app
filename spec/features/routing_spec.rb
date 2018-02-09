feature "Served pages" do

	scenario "homepage" do
		visit '/'
		expect(page).to have_content 'Welcome'
	end

  scenario "User visits non-existant page" do
  	visit '/bloopers'
  	expect(page).to have_content '404 Error Page not found'
  end
end

feature "Served files" do
	scenario "request a public file" do
		visit'/public/sign-up.html'
		expect(page).to have_content "Sign Up"
	end
end
