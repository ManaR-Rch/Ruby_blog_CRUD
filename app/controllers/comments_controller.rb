class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    user = User.first
    result = Comments::Create.call(user: user, post: @post, params: comment_params)

    if result.success?
      flash[:notice] = "Comment was successfully created."
      redirect_to @post
    else
      flash[:alert] = friendly_comment_error(result.error)
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

  def friendly_comment_error(code)
    case code
    when :invalid
      "Comment cannot be blank or invalid."
    when :spam_blocked
      "Your comment looks like spam and was blocked."
    else
      "There was an error creating the comment."
    end
  end
end
