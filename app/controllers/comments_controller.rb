# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    return render_unauthorized unless user_signed_in?

    values = params.require(:post_comment).permit(:parent_id, :content)
    post = Post.find(params.require(:post_id))
    parent = values[:parent_id].blank? ? nil : PostComment.find(values[:parent_id])
    @comment = PostComment.create(parent: parent, post: post, user: current_user, content: values[:content])
    if @comment.new_record?
      error_text = @comment.errors.map do |v|
        "#{PostComment.human_attribute_name(v.attribute)} #{@comment.errors[v.attribute.to_sym].join(', ')}"
      end.join('\n')
      redirect_to post_path(post.id), id: post.id, alert: error_text
    else
      redirect_to post_path(post.id), success: t('messages.comment_created')
    end
  end
end
