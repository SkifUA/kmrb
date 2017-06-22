require 'spec_helper'
require "rails_helper"

feature "Login" do

  scenario "User not create" do
    visit "/users/new"

    fill_in "First name", with: "Tom"
    fill_in "Last name", with: "Smeet"
    fill_in "Email", with: "My@Widget"
    fill_in "Password", with: "111"
    fill_in "Password confirmation", with: "111"
    click_button "Create"
    expect(page).to have_text(User::ERROR_MESSAGE_CREATE_USER)
  end

  scenario "User create" do
    visit "/users/new"

    fill_in "First name", with: "Tom"
    fill_in "Last name", with: "Smeet"
    fill_in "Email", with: "My_email@example.com"
    fill_in "Password", with: "1111"
    fill_in "Password confirmation", with: "1111"
    click_button "Create"
    expect(page).to have_text(User::SUCCESS_MESSAGE_CREATE_USER)
  end

end