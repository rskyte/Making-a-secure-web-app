feature "Served pages" do

	scenario "homepage" do
		visit '/'
		expect(page).to have_content 'Welcome'
	end

  scenario "Displays 'Hello World!'" do
    visit '/users'
    expect(page).to have_content 'Hello World!'
    expect(page).to_not have_content "I don't exist"
  end

  scenario "Displays a sign up page" do
  	visit '/users/new'
  	expect(page).to have_content 'Sign Up'
  end

	scenario "user signs up- redirects to posts page" do
		sign_up()
  	expect(page).to have_content "Signed in as testuser"
  end

	scenario "user can visit signin page" do
		visit '/users/signin'
		expect(page).to have_content "Sign In"
	end

	scenario "User can signin to their existing account" do
		sign_up()
		click_link "Sign Out"
		sign_in()
		expect(page).to have_content "Signed in as testuser"
	end

	scenario "User cannot view the posts page if not logged in" do
		visit '/posts'
		expect(page).to have_content 'Sign In'
	end

	scenario "User can view the posts page if they are logged in" do
		sign_up()
		sign_in()
		expect(page).to have_content 'Sign Out'
	end

	scenario "Post page shows which user is logged in" do
		sign_up()
		sign_in()
		visit '/posts'
		expect(page).to have_content 'Signed in as testuser'
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
