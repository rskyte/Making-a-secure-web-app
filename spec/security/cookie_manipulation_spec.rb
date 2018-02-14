feature "Cookie Manipulation" do

  scenario "cookies cannot be hijacked (via simple javascript manipulation)" do
    sign_up(username: "victim")
    id = User.find_first({"username" => "victim"}).id
    click_link "Sign Out"
    sign_up(username: "hijacker")
    page.execute_script("document.cookie = 'user-id=#{id}'")
    make_post("Hijacked")
    expect(page).to_not have_content "victim"
  end
end
