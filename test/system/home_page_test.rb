require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path
    assert_selector "h1", text: "Burritos"
  end
end
