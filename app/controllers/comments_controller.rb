# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_post
    @parent = parent_comment

    @comment = current_user.comments.build(**params_permitted.to_hash, post: @post, parent: @parent)

    if @comment.save
      flash[:success] = t('messages.comment_created')
    else
      flash[:alert] = @comment.errors.full_messages.join('. ')
    end
    redirect_to post_path(@post)
  end

  private

  def params_permitted
    @params_permitted || @params_permitted = params.require(:post_comment).permit(:parent_id, :content)
  end

  def current_post
    Post.find(params[:post_id])
  end

  def parent_comment
    if params_permitted[:parent_id].present?
      PostComment.find(params_permitted[:parent_id])
    end
  end
end
