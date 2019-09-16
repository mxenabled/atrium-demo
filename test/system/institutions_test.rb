require "application_system_test_case"

class InstitutionsTest < ApplicationSystemTestCase
  setup do
    @institution = institutions(:one)
  end

  test "visiting the index" do
    visit institutions_url
    assert_selector "h1", text: "Institutions"
  end

  test "creating a Institution" do
    visit institutions_url
    click_on "New Institution"

    fill_in "Code", with: @institution.code
    fill_in "Name", with: @institution.name
    click_on "Create Institution"

    assert_text "Institution was successfully created"
    click_on "Back"
  end

  test "updating a Institution" do
    visit institutions_url
    click_on "Edit", match: :first

    fill_in "Code", with: @institution.code
    fill_in "Name", with: @institution.name
    click_on "Update Institution"

    assert_text "Institution was successfully updated"
    click_on "Back"
  end

  test "destroying a Institution" do
    visit institutions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Institution was successfully destroyed"
  end
end
