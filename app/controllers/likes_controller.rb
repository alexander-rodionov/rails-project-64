# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :parse_post

  def parse_post
    @post = Post.find(params.require(:post_id))
  end

  def toggle
    return render_unauthorized unless user_signed_in?

    liked? ? unlike(skip_check: true) : like(skip_check: true)
    redirect_to post_path(@post)
  end

  def create
    return render_unauthorized unless user_signed_in?

    like
    redirect_to post_path(@post)
  end

  def destroy
    return render_unauthorized unless user_signed_in?

    unlike
    redirect_to post_path(@post)
  end

  private

  def liked?
    @post.likes.exists?(user: current_user)
  end

  def like(skip_check: false)
    @post.likes.create(post: @post, user: current_user) if skip_check || !liked?
  end

  def unlike(skip_check: false)
    @post.likes.find_by(user: current_user).destroy if skip_check || liked?
  end
end
