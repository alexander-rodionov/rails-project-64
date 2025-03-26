# frozen_string_literal: true

require "test_helper"

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    assert User.size>0
    assert User.exists?(email:'johndoe@mail.cc')
    assert Category.size>0
    assert Post.size>0
    assert PostComment.size>0
  end

  test "home page" do

  end

  test "posts listed" do
    
  end


  test "login possible" do
    
  end

  test "registration possible" do
    
  end



end
