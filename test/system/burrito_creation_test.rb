require "application_system_test_case"

class BurritoCreationTest < ApplicationSystemTestCase
  test "admin can create a burrito" do
    # setup data for test
    admin = User.create!(email: "sysadmin@example.com", password: "password", is_admin: 1)
    t = Tortilla.create!(name: "flour")
    s = Size.create!(name: "medium")
    f = Filling.create!(name: "beans")
    top = Topping.create!(name: "cheese")

    visit root_path
    # reveal login form (layout toggle) and sign in
    execute_script("document.getElementById('login-form').style.display='block'")
    fill_in "Email", with: admin.email
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Create Burrito"
    fill_in "Name", with: "Test Burrito"
    select t.name, from: "Tortilla"
    select s.name, from: "Size"
    check f.name
    check top.name
    click_button "Create Burrito" if page.has_button?("Create Burrito")
    # fallback: submit the form
    click_button "Save" if page.has_button?("Save")

    assert_text "Burrito"
    assert_text "Test Burrito"
  end
end
