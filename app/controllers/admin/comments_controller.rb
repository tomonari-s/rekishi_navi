class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_post_path(comment.id)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
