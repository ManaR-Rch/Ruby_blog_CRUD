class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = User.first

    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error creating the comment."
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted."
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find_by!(slug: params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
