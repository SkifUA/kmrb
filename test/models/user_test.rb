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

  test "password should be present" do
    @user.password_confirmation = "     "
    assert_not @user.valid?
  end

  test "confirmation should be present" do
    @user.password_confirmation = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

end
