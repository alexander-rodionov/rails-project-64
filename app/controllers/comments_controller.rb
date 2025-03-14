class CommentsController < ApplicationController
  before_action :assert_logged_in


  def create
    begin
      values = params.require(:post_comment).permit(:parent_id, :content)
      post = Post.find(params.require(:post_id))
      parent = values[:parent_id].empty? ? nil : PostComment.find(values[:parent_id])
      PostComment.create!(parent: parent, post: post, creator: @current_user, content: values[:content])
    rescue Exception => e
      pp e
    ensure
      redirect_to post_path(post)
    end
  end
end
