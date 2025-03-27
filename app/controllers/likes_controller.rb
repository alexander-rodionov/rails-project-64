# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :parse_post

  def parse_post
    pp 'PARSE POST-------------------------------'
    @post = Post.find(params.require(:post_id))
  end

  def toggle
    return render_unauthorized unless user_signed_in?

    pp "--------------------- TOGGLE #{params}"
    liked? ? unlike : like
    redirect_to post_path(@post)
  end

  def create
    return render_unauthorized unless user_signed_in?

    pp "--------------------- CREATE #{params}"
    like
    redirect_to post_path(@post)
  end

  def destroy
    return render_unauthorized unless user_signed_in?

    pp "--------------------- DESTROY #{params}"
    unlike
    redirect_to post_path(@post)
  end

  private

  def liked?
    p 'LIKED?'
    p @post.post_likes.exists?(user: current_user)
  end

  def like
    p 'LIKE'
    p @post.post_likes.create(post: @post, user: current_user) unless liked?
  end

  def unlike
    p 'UNLIKE'
    @post.post_likes.find_by(user: current_user).destroy if liked?
  end

  # def params_permitted
  #   params.require(:like).permit(:id)
  # end
end
