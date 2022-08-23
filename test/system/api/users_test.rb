require "application_system_test_case"

class Api::UsersTest < ApplicationSystemTestCase
  setup do
    @api_user = api_users(:one)
  end

  test "visiting the index" do
    visit api_users_url
    assert_selector "h1", text: "Api/Users"
  end

  test "creating a User" do
    visit api_users_url
    click_on "New Api/User"

    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit api_users_url
    click_on "Edit", match: :first

    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit api_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
