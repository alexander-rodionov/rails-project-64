# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test 'should sign_up' do
    get user_new_url
    assert_response :success
  end

  test 'should register' do
    get user_new_url
    assert_response :success
  end


  test 'should sign_in' do
    get user_login_url
    assert_response :success
  end

  test 'should sign_out' do
    get user_logout_url
    assert_response :success
  end
end
