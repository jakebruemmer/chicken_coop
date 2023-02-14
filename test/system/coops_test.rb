require "application_system_test_case"

class CoopsTest < ApplicationSystemTestCase
  setup do
    @coop = coops(:one)
  end

  test "visiting the index" do
    visit coops_url
    assert_selector "h1", text: "Coops"
  end

  test "should create coop" do
    visit coops_url
    click_on "New coop"

    fill_in "Name", with: @coop.name
    click_on "Create Coop"

    assert_text "Coop was successfully created"
    click_on "Back"
  end

  test "should update Coop" do
    visit coop_url(@coop)
    click_on "Edit this coop", match: :first

    fill_in "Name", with: @coop.name
    click_on "Update Coop"

    assert_text "Coop was successfully updated"
    click_on "Back"
  end

  test "should destroy Coop" do
    visit coop_url(@coop)
    click_on "Destroy this coop", match: :first

    assert_text "Coop was successfully destroyed"
  end
end
