require 'rails_helper'

describe User do

  let(:user) { create :user }

  it 'works' do
    expect(user).to be_a User
  end

  it 'is valid' do
    expect(user).to be_valid
  end

  # name
  it 'first_name should not be too long' do
    user.first_name = "a" * (User::NAME_LENGTH_MAX + 1)
    expect(user).to be_invalid
  end

  it "last_name should not be too long" do
    user.last_name = "a" * (User::NAME_LENGTH_MAX + 1)
    expect(user).to be_invalid
  end

  # password
  it 'password should be present' do
    user.password = ' '
    expect(user).to be_invalid
  end

  it 'password_confirmation should be present' do
    user.password = '1233456'
    expect(user).to be_invalid
  end

  it 'last_name should not be too long' do
    user.password = "a" * (User::EMAIL_LENGTH_MAX + 1)
    expect(user).to be_invalid
  end

  # email
  it "email is validated" do
    expect(user).to validate_presence_of(:email)
  end

  it "email should be present" do
    user.email = "     "
    expect(user).to be_invalid
  end

  it "email should not be too long" do
    user.email = "a" * User::EMAIL_LENGTH_MAX  + "@example.com"
    expect(user).to be_invalid
  end

  it 'email addresses should be unique' do
    duplicate_user = user.dup
    user.save
    expect(duplicate_user).to be_invalid
  end

  it 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it 'email addresses should be saved as lower-case' do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(mixed_case_email.downcase).to eq(user.reload.email)
  end

end