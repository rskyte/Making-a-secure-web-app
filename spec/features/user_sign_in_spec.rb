feature "User - Sign In" do

  scenario "can visit signin page" do
    visit '/users/signin'
    expect(page).to have_content "Sign In"
  end

  scenario "can signin to their existing account" do
    sign_up()
    click_link "Sign Out"
    sign_in()
    expect(page).to have_content "Signed in as testuser"
  end

  scenario "cannot sign in with incorrect details" do
    sign_up
    click_link "Sign Out"
    sign_in(password: "incorrect")
    expect(page).to have_content "Sign In"
  end

  scenario "cannot view the posts page if not logged in" do
    visit '/posts'
    expect(page).to have_content 'Sign In'
  end

  scenario "can view the posts page if they are logged in" do
    sign_up()
    sign_in()
    expect(page).to have_content 'Sign Out'
  end

end
