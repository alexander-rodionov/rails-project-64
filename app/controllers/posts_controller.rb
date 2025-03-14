include ActionView::Helpers::DateHelper
class PostsController < ApplicationController
  before_action :assert_logged_in
  before_action :get_current_user
  before_action :get_current_post, only: %i[show create]

  def get_current_post
    @post = Post.find(params.require(:id))
  end

  def index
    @posts = Post.order(created_at: :desc).all
  end

  def show
    @new_comment = PostComment.new
    #credirect_to posts_path
  end

  def new
  end

  def create
  end


  def get_new_comment(parent)
    if parent.is_a? Post
      parent.post_comment.new
    elsif parent.is_a? PostComment
      parent.children.new
    else
      raise Exception("Unknown parent. This can't happen")
    end
  end

  def has_like?
    @post.post_like.where(creator: @current_user).pluck(:id).any?
  end
end
