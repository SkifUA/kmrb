require 'spec_helper'
require "rails_helper"

feature "Login" do

  let(:group_admin) { build :group_admin }
  let(:user) { build :user }
  let(:admin) { build :admin }

  scenario "User login" do
    visit "/login"

    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "1111"
    click_button "Log in"
    expect(page).to have_text('Home')
  end

  scenario "User not login" do
    visit "/login"

    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "22222"
    click_button "Log in"
    expect(page).to have_text(I18n.t 'error_msg_auth')
  end

  scenario "User go to forgot" do
    visit "/login"

    page.find('a', text: 'Forgot password').click
    expect(page).to have_text("Forgot password")
  end

end