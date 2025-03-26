class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post

  def get_post
    @post = Post.find(params.require(:post_id))
  end

  def toggle
    liked? ? unlike : like
    redirect_to post_path(@post)
  end

  def create
    like
    redirect_to post_path(@post)
  end
  
  def destroy
    unlike
    redirect_to post_path(@post)
  end

  private

  def liked?
    @post.post_like.exists?(user: current_user)
  end

  def like
    @post.post_like.create(post: @post, user: current_user) unless liked?
  end

  def unlike
    @post.post_like.find_by(user: current_user).destroy if liked?
  end

  # def params_permitted
  #   params.require(:like).permit(:id)
  # end
end
