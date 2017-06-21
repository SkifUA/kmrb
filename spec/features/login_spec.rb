require 'spec_helper'
require "rails_helper"

RSpec.feature "Login", :type => :feature do
  scenario "User creates a new widget" do
    visit "/login"

    # fill_in "Name", :with => "My Widget"
    # click_button "Create Widget"
    page.find('a', text: 'Forgot password').click
    expect(page).to have_text("Forgot password")
  end
end