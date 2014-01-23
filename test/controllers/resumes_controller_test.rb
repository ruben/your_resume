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
    stub_profile_info
    get :refresh
    assert_redirected_to resumes_show_path
  end

  def self.stub_profile_info
    LinkedIn::Client.any_instance.stubs(:profile_info).returns(JSON.parse '{"firstName": "Rubén", "summary": "Rubén has a loooot of experience"}')
  end
end