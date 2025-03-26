include ActionView::Helpers::DateHelper
class PostsController < ApplicationController
  before_action :get_current_post, only: %i[show]

  def get_current_post
    @post = Post.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: t('post.not_found')
  end

  def index
    @posts = Post.latest_last.all
  end

  def show
    @new_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def post_params
    params_permited=params.require(:post).permit(%i[title body category_id])
  end


  def create
    @post = Post.new(post_params)
    @post.status = 'published'
    @post.creator = current_user
    if @post.save
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def new_comment(parent)
    case parent
    when Post
      parent.post_comment.new
    ehrn PostComment
      parent.children.new
    else
      raise Exception("Unknown parent type #{parent.class.name}. This can't happen")
    end
  end

  def liked_by_current_user?
    @post.post_like.exists?(creator: current_user)
  end
end
