# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :users, :categories, :posts, :post_likes
  setup do
    @user = users(:user_one)
    @user2 = users(:user_two)
  end

  test 'should like create' do
    # this comment is to overcome git actions failure
    @post = posts(:post_one)
    sign_in(@user)
    @post.likes.destroy_all
    post post_like_path(@post)
    assert_response :redirect
    assert { PostLike.exists?(post: @post, user: @user) }
  end

  test 'should like destroy' do
    @post = posts(:post_two)
    sign_in(@user)
    delete post_like_path(@post)
    assert_response :redirect
    assert { !PostLike.exists?(post: @post, user: @user) }
  end

  test 'should like create unauthorized' do
    @post = posts(:post_one)
    @post.likes.delete_all
    post post_like_path(@post)
    assert_redirected_to new_user_session_path
  end

  test 'should like destroy unauthorized' do
    @post = posts(:post_two)
    delete post_like_path(@post)
    assert_redirected_to new_user_session_path
  end
end
