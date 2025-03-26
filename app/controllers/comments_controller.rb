class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    values = params.require(:post_comment).permit(:parent_id, :content)
    post = Post.find(params.require(:post_id))
    parent = values[:parent_id].nil? || values[:parent_id].empty? ? nil : PostComment.find(values[:parent_id])
    @comment = PostComment.create(parent: parent, post: post, user: current_user, content: values[:content])
    if @comment.new_record?
      error_text = @comment.errors.map do |v|
        p "#{PostComment.human_attribute_name(v.attribute)} #{@comment.errors[v.attribute.to_sym].join(', ')}"
      end.join('\n')
      redirect_to post_path(post.id), id: post.id, alert: error_text
    else
      redirect_to post_path(post.id), success: t('messages.comment_created')
    end
  end
end
