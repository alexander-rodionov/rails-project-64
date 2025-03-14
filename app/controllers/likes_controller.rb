class LikesController < ApplicationController
  before_action :assert_logged_in

  def toggle
    post_id = params.require(:post_id)
    post = Post.find(post_id)
    if post.post_like.where(creator_id: @current_user.id).pluck(:id).empty?
      post.post_like.create(post_id: post_id, creator_id: @current_user.id)
    else
      post.post_like.where(creator_id: @current_user.id).delete_all
    end
    redirect_to post_path(post_id)
  end
end
