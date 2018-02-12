feature "User - Sign Up" do

  scenario "displays a sign up page" do
    visit '/users/new'
    expect(page).to have_content 'Sign Up'
  end

  scenario "cannot sign up with non-matching passwords" do
    sign_up(password_conf: "incorrect")
    message = page.find("#password-conf").native.attribute("validationMessage")
    expect(message).to eq "Please match the requested format: Passwords must match."
  end

  scenario "cannot sign up with short password" do
    sign_up(password: "short")
    message = page.find("#password").native.attribute("validationMessage")
    expect(message).to eq "Please use at least 7 characters (you are currently using 5 characters)."
  end

  # scenario "cannot sign up with a username which is already taken" do
  #   sign_up
  #   click_link "Sign Out"
  #   sign_up
  #   expect(page).to have_content "Username already taken!"
  # end

  scenario "can sign up with valid details" do
    sign_up()
    expect(page).to have_content("Signed in as testuser")
  end

  scenario "password cannot be empty" do
    sign_up(password: "")
    message = page.find("#password").native.attribute("validationMessage")
    expect(message).to eq "Please fill in this field."
  end

  scenario "username cannot be empty" do
    sign_up(username: "")
    message = page.find("#username").native.attribute("validationMessage")
    expect(message).to eq "Please fill in this field."
  end

end
