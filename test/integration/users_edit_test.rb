require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:crypto)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username:  "",
                                              first_name: "",
                                              last_name: "",
                                              email: "crypto@hacker",
                                              password:              "soft",
                                              password_confirmation: "ware" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    username  = "CryptoH4ck3r"
    first_name = "Crypto"
    last_name = "H4ck3r"
    email = "cryptoh4ck3r@proton.me"
    patch user_path(@user), params: { user: { username:  username,
                                              first_name: first_name,
                                              last_name: last_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username,  @user.username
    assert_equal first_name, @user.first_name
    assert_equal last_name, @user.last_name
    assert_equal email, @user.email
  end

end
