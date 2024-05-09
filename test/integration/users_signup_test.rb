require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username:  "",
                                         first_name: "",
                                         last_name: "",
                                         agency_name: "",
                                         access_code: "",
                                         email: "agent@tsu",
                                         password:              "soft",
                                         password_confirmation: "ware" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end


  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username:  "CryptoH4ck3r",
                                         first_name: "Crypto",
                                         last_name: "H4ck3r",
                                         agency_name: "Texas Specialty Underwriters",
                                         access_code: "123",
                                         email: "crypto@texasspecialtyunderwriters.com",
                                         password:              "software",
                                         password_confirmation: "software" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
