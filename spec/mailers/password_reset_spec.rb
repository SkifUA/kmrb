require 'rails_helper'

  describe UserMailer do
    let(:user) do
      User.new(
          first_name: "Example",
          last_name: 'User',
          email: "user@example.com",
          password: '111111',
          password_confirmation: '111111',
      )
    end

    let(:mail) do
      user.create_reset_digest
      UserMailer.password_reset(user)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["user@example.com"])
      expect(mail.from).to eq([ENV['MAILER_USER_NAME']])
    end

  end
