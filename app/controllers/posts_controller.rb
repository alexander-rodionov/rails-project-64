include ActionView::Helpers::DateHelper
class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :get_current_post, only: %i[show]

  def get_current_post
    @post = Post.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: t("post.not_found")
  end

  def index
    @posts = Post.latest.all
  end

  def show
    @new_comment = PostComment.new
    put File.read("/project/test/controllers/likes_controller_test.rb")

  end

  def new
    @post = Post.new
  end

  def post_params
    params_permited=params.require(:post).permit(%i[title body category_id])
  end

  def create
    @post = Post.new(post_params)
    @post.status = "published"
    @post.creator = current_user
    if @post.save
      redirect_to posts_path(@post), success: t("messages.post_created")
    else
      flash[:alert] = t("messages.post_create_failed")
      render :new, status: 422, alert:
    end
  end

  def new_comment(parent)
    case parent
    when Post
      parent.post_comments.new
    when PostComment
      parent.children.new
    else
      raise Exception("Unknown parent type #{parent.class.name}. This can't happen")
    end
  end

  def liked_by_current_user?
    @post.post_likes.exists?(user: current_user)
  end
end
