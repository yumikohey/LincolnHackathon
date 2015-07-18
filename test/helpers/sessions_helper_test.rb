require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

	def setup
		@user = users(:yumiko)
		remember(@user)
	end

  test "current_user returns right user when session is nil" do
    user = users(:michael)
    remember(user)
    assert_equal user, current_user
  end

  test "current_user returns nil when remember digest is wrong" do
  	@user.update_attribute(:remember_digest, User.digest(User.new_token))
  	assert_nil current_user
  end
end