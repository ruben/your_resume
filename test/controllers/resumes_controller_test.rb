require 'test_helper'

class ResumesControllerTest < ActionController::TestCase
  setup do
    @user = users :rubengil
    sign_in @user
    stub_linked_in_client
  end

  test "shows resume" do
    get :show
    assert_response :success
  end

  test "refreshes resume" do
    get :refresh
    assert_redirected_to resumes_show_path
  end
end