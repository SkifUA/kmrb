require 'spec_helper'
require "rails_helper"

feature "Login" do

  scenario "send message" do
    visit "/password_resets/new"

    fill_in "Email", with: "user@example.com"
    click_button "Send"

    expect(page).to have_text(I18n.t 'error_msg_email_notfound')
  end

end