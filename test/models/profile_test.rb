require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    stub_linked_in_client "ruben", "ruben_new_access_token"
  end

  test "Loads summary" do
    @profile = Profile.create_from @client
    assert_not_nil @profile.summary
  end

  test "Loads associations" do
    [
      { result: "Position.count", expected: @client.profile_info['positions']['_total'] },
      { result: "Project.count",  expected: @client.profile_info['projects']['_total'] },
      { result: "Education.count",  expected: @client.profile_info['educations']['_total'] },
      { result: "Certification.count",  expected: @client.profile_info['certifications']['_total'] },
      { result: "Language.count",  expected: @client.profile_info['languages']['_total'] }
    ].each do |child|
      assert_difference child[:result], child[:expected] do
        Profile.create_from @client
      end
    end
  end

  test "Double import" do
    assert_difference "Position.count", @client.profile_info['positions']['_total'] do
      profile = Profile.create_from @client
      profile.load_from @client
    end
  end
end
