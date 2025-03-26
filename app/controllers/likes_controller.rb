class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post

  def get_post
    @post = Post.find(params.require(:post_id))
  end

  def toggle
    if @post.post_like.where(user: current_user).pluck(:id).empty?
      @post.post_like.create(post: @post, user: current_user)
    else
      @post.post_like.where(user: current_user).delete_all
    end
    redirect_to post_path(@post)
  end

  def create
    pp params
    redirect_to post_path(@post)
  end
  
  def destroy
    pp params
    redirect_to post_path(@post)
  end

  def params_permitted
    params.require(:like).permit(:id)
  end
end
