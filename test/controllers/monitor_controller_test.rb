# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should respond to up monitor' do
    get rails_health_check_path
    assert_response :success
  end

  test 'should respond to exception_check monitor' do
    original_show_exceptions = Rails.application.env_config['action_dispatch.show_exceptions']
    original_show_details = Rails.application.env_config['action_dispatch.show_detailed_exceptions']
    Rails.application.env_config['action_dispatch.show_exceptions'] = true
    Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = false

    get rails_exception_path
    assert_response :internal_server_error
  ensure
    Rails.application.env_config['action_dispatch.show_exceptions'] = original_show_exceptions
    Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = original_show_details
  end

  test 'should respond to sentry_check monitor' do
    get sentry_exception_path
    assert_response :redirect
    assert_redirected_to root_path
  end
end
