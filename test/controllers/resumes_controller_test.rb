require 'test_helper'

class ResumesControllerTest < ActionController::TestCase
  setup do
    @user = users :rubengil
    sign_in @user
  end

  test "shows resume" do
    get :show
    assert_response :success
  end

  test "refreshes resume" do
    stub_get_profile_info @user.access_token, Profile.new(first_name: "Rubén", summary: "Rubén has a loot of experience")
    get :refresh
    assert_redirected_to resumes_show_path
  end
end