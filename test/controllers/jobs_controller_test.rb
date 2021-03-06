require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:grant)
    @jobs = Job.all
    @jobs.each do |job|
      job.users << users(:john)
    end
    log_in_as(@user)
  end

  test "should get index" do
    get jobs_path
    assert_response :success
  end

  test "should get new" do
    get new_job_path
    assert_response :success
  end

end
