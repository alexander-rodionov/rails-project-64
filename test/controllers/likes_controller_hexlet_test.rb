# frozen_string_literal: true

require 'test_helper'
class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:post_two)
    @post2 = posts(:post_one)
    @user = users(:user_one)
  end

  test '#create' do
    sign_in @user
    post post_likes_path(@post2)
    assert_response :redirect

    post_like = @post2.likes.find_by(user: @user)

    assert { post_like }
  end

  test '#destroy' do
    sign_in @user
    like = post_likes(:like_one)

    delete post_like_path(@post, like)
    assert_response :redirect

    assert { !PostLike.exists?(like.id) }
  end

  test '#destroy by other user' do
    other_user = users(:user_two)
    sign_in other_user
    like = post_likes(:like_one)

    delete post_like_path(@post, like)
    assert_response :redirect

    assert { PostLike.exists?(like.id) }
  end
end
