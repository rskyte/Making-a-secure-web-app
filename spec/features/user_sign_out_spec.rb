feature 'User - Sign Out' do
  scenario 'can sign out' do
    sign_up
    click_link 'Sign Out'
    expect(page).to have_content 'Sign In'
  end
end
