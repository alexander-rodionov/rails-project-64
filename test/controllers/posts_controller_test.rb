# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :categories, :users, :posts

  setup do
    @current_post = posts(:post_one)
    @new_post_hash = {
      title: 'Gibbering comprehension stygian daemoniac noisome.',
      category_id: categories(:category_two).id,
      body: 'Hideous madness cat non-euclidean manuscript loathsome singular cyclopean. Immemorial stench madness comprehension fainted mortal. Daemoniac tenebrous nameless. Furtive fungus hideous manuscript foetid decadent unutterable. Tenebrous foetid unnamable.'
    }
  end

  test 'should get index not signed' do
    get posts_path
    assert_response :success
    assert_match posts(:post_one).title, response.body
    assert_match posts(:post_two).title, response.body
  end

  test 'should get index signed' do
    sign_in(users(:user_one))
    get posts_path
    assert_response :success
    assert_match posts(:post_one).title, response.body
    assert_match posts(:post_two).title, response.body
  end

  test 'should get show unsigned' do
    get posts_path(@current_post)
    assert_response :success
    assert_match @current_post.title, response.body
    assert_match @current_post.body, response.body
  end

  test 'should get show signed' do
    sign_in(users(:user_one))
    get posts_path(@current_post)
    assert_response :success
    assert_match @current_post.title, response.body
    assert_match @current_post.body, response.body
  end

  test 'should make new post ok' do
    sign_in(users(:user_one))
    post_hash = @new_post_hash.dup
    post posts_path, params: { post: post_hash }
    assert_response :redirect
    follow_redirect!
    assert_match post_hash[:title], response.body
    assert_match post_hash[:body], response.body
  end

  test 'should make new post fail 1' do
    sign_in(users(:user_one))
    post_hash = @new_post_hash.dup
    post_hash[:title] = post_hash[:title][0..3]
    post posts_path, params: { post: post_hash }
    assert_response :unprocessable_content
  end

  test 'should make new post fail 2' do
    sign_in(users(:user_one))
    post_hash = @new_post_hash.dup
    post_hash[:body] = post_hash[:body][0..3]
    post posts_path, params: { post: post_hash }
    assert_response :unprocessable_content
  end

  test 'should make new post unsigned' do
    post_hash = @new_post_hash.dup
    post posts_path, params: { post: post_hash }
    assert_response :redirect
    follow_redirect!
    assert_no_match post_hash[:title], response.body
    assert_no_match post_hash[:body], response.body
  end

  # test "should get new" do
  #   get posts_new_url
  #   assert_response :success
  # end

  # test "should get create" do
  #   get posts_create_url
  #   assert_response :success
  # end
end
