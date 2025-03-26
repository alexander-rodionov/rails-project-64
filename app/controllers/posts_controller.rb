include ActionView::Helpers::DateHelper
class PostsController < ApplicationController
  before_action :get_current_post, only: %i[show]

  def get_current_post
    @post = Post.find(params.require(:id))
  end

  def index
    @posts = Post.order(created_at: :desc).all
  end

  def show
    @new_comment = PostComment.new
    # redirect_to posts_path
  end

  def new
    @post = Post.new
  end

  def create
    params_permited=params.require(:post).permit(%i[title body category_id]).to_h
    params_permited['status']='published'
    params_permited['creator']=current_user
    @post = Post.new(params_permited)
    if @comment.new_record?
      render 'posts/new', status: :unprocessable_entity, alert: t('messages.post_create_failed')
    else
      redirect_to posts_path(@post), notice: t('messages.post_created')
    end
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
    @post.post_like.where(creator: current_user).pluck(:id).any?
  end
end
