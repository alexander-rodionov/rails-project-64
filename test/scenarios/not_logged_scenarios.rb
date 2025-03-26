# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    assert User.size.positive?
    assert User.exists?(email: 'johndoe@mail.cc')
    assert Category.size.positive?
    assert Post.size.positive?
    assert PostComment.size.positive?
  end

  # test 'home page' do
  #   nil
  # end

  # test 'posts listed' do
  #   nil
  # end

  # test 'login possible' do
  #   nil
  # end

  # test 'registration possible' do
  #   nil
  # end
end
