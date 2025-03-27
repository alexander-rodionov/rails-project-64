# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users, :categories, :posts, :post_comments
  include Devise::Test::IntegrationHelpers

  setup do
    @content = 'asdfasdfasdfasdfasdfasdfasdf'
  end

  test 'should make post comment' do
    sign_in(users(:user_one))
    @post = posts(:post_one)
    params = {
      post_comment: {
        parent_id: nil,
        content: @content
      }
    }
    post post_comments_path(@post), params: params
    assert_response :redirect
    follow_redirect!
    assert_match @content, response.body
  end

  test 'should make post comment fail' do
    sign_in(users(:user_one))
    @post = posts(:post_one)
    params = {
      post_comment: {
        parent_id: nil,
        content: @content[0..3]
      }
    }
    post post_comments_path(@post), params: params
    assert_response :redirect
    follow_redirect!
    assert_match 'Тело комментария недостаточной длины (не может быть меньше 5 символов)', response.body
    assert_no_match @content, response.body
  end

  test 'should make post sub comment' do
    sign_in(users(:user_one))
    @post = posts(:post_two)
    params = {
      post_comment: {
        parent_id: post_comments(:comment_one).id,
        content: @content
      }
    }
    post post_comments_path(@post), params: params
    assert_response :redirect
    follow_redirect!
    assert_match @content, response.body
  end

  test 'should make post comment unsigned' do
    @post = posts(:post_one)
    params = {
      post_comment: {
        parent_id: nil,
        content: @content
      }
    }
    post post_comments_path(@post), params: params
    assert_redirected_to new_user_session_path
  end

  test 'should make post sub comment  unsigned' do
    @post = posts(:post_two)
    params = {
      post_comment: {
        parent_id: post_comments(:comment_one).id,
        content: @content
      }
    }
    post post_comments_path(@post), params: params
    assert_redirected_to new_user_session_path
  end
end
