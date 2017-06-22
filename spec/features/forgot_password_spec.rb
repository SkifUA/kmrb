require 'spec_helper'
require "rails_helper"

feature "Forgot password" do
let(:user) { create :user }

  scenario "send message" do
    visit "/password_resets/new"

    fill_in "Email", with: user.email
    click_button "Send"

    expect(page).to have_text(I18n.t 'success_msg_send_reset_mail')
  end

  scenario "not send message" do
    visit "/password_resets/new"

    fill_in "Email", with: "example@example.com"
    click_button "Send"

    expect(page).to have_text(I18n.t 'error_msg_email_notfound')
  end

end