require_relative '../../app/models/post'
feature('XSS attack') do
  scenario('A user can input a malicious post that displays browser alerts') do
    sign_up
    make_post('<script>window.alert("Hello world")</script>')
    sleep(1)
    visit '/posts'
    alert = page.driver.browser.switch_to.alert.text
    expect(alert).to have_content "Hello world"
  end
end
