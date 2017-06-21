require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(
        first_name: "Example",
        last_name: 'User',
        email: "user@example.com",
        password: '111111',
        password_confirmation: '111111'
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * (User::NAME_LENGTH_MAX + 1)
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * (User::NAME_LENGTH_MAX + 1)
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "password_confirmation should be present" do
    @user.password_confirmation = "222222"
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * User::EMAIL_LENGTH_MAX  + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

end
