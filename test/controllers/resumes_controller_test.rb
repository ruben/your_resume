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
    LinkedIn::Client.any_instance.stubs(:get_profile_info).returns('{"firstName": "Rubén", "summary": "Rubén has a loooot of experience"}')
    get :refresh
    assert_equal "Rubén has a loooot of experience", @user.profile.summary
    assert_redirected_to resumes_show_path
  end
end