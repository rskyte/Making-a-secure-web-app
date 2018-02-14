require_relative '../../app/models/post'
feature('XSS attack') do

  scenario('A user cannot input a malicious post that displays browser alerts') do
    sign_up
    make_post('<script>window.alert("Hello world")</script>')
    sleep(1)
    visit '/posts'
    expect { page.driver.browser.switch_to.alert }.to raise_error
  end
end
