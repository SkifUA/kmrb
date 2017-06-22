require 'rails_helper'

  describe UserMailer do
    let(:user) do
      User.create(
          first_name: "Example",
          last_name: 'User',
          email: "user@example.com",
          password: '111111',
          password_confirmation: '111111',
      )
    end

    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq(["user@example.com"])
      expect(mail.from).to eq([ApplicationMailer::DEFAULT_MAIL_FROM])
    end

  end
