require 'spec_helper'
require "rails_helper"

feature "Login" do

  scenario "User not login" do
    visit "/login"

    fill_in "Email", :with => "My@Widget"
    fill_in "Password", :with => "1111"
    click_button "Log in"
    expect(page).to have_text(User::ERROR_MESSAGE_AUTH)
  end

  scenario "User go to forgot" do
    visit "/login"

    page.find('a', text: 'Forgot password').click
    expect(page).to have_text("Forgot password")
  end

end