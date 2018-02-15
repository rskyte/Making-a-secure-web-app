feature 'Served pages' do
  scenario 'User visits non-existant page' do
    visit '/bloopers'
    expect(page).to have_content '404 Error Page not found'
  end
end

feature 'Served files' do
  scenario 'request a public file' do
    visit'/public/sign-in.html'
    expect(page).to have_content 'Sign In'
  end
end
