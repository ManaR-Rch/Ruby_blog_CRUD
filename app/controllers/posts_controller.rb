class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user, :comments).all
    @posts = @posts.published if params[:status] == "published"
    @posts = @posts.drafts if params[:status] == "drafts"
    @posts = @posts.by_author(params[:author_id]) if params[:author_id].present?
    @posts = @posts.search(params[:q]) if params[:q].present?
    @posts = @posts.recent
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first || User.create!(email: "user@example.com", name: "User", role: "member")

    if @post.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "Post was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating the post."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Post was successfully deleted." }
    end
  end

  private

  def set_post
    @post = Post.find_by!(slug: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
