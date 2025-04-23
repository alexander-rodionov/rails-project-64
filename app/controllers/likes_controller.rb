# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def set_post
    @post = Post.find(params.require(:post_id))
  end

  def create
    @post.likes.create(post: @post, user: current_user)
    redirect_to post_path(@post)
  end

  def destroy
    @post.likes.find_by(user: current_user)&.destroy
    redirect_to post_path(@post)
  end
end
