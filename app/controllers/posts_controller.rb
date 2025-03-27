# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :parse_current_post, only: %i[show]

  def index
    @posts = Post.latest.all
  end

  def show
    @new_comment = PostComment.new
  end

  def new
    return render_unauthorized unless user_signed_in?

    @post = Post.new
  end

  def create
    return render_unauthorized unless user_signed_in?

    @post = Post.new(post_params)
    @post.status = 'published'
    @post.creator = current_user
    if @post.save
      redirect_to posts_path(@post), success: t('messages.post_created')
    else
      flash[:alert] = t('messages.post_create_failed')
      render :new, status: :unprocessable_content, alert:
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

  private

  def post_params
    params.require(:post).permit(%i[title body category_id])
  end

  def parse_current_post
    @post = Post.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: t('post.not_found')
  end
end
