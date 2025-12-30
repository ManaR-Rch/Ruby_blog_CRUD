class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy publish unpublish]
  before_action :authenticate_user!, except: %i[index show]


  def index
    @posts = authorized_scope(Post.includes(:user, :comments)).recent
    @posts = @posts.published if params[:status] == "published"
    @posts = @posts.drafts if params[:status] == "drafts"
    @posts = @posts.by_author(params[:author_id]) if params[:author_id].present?
    @posts = @posts.search(params[:q]) if params[:q].present?
    
    respond_to do |format|
      format.turbo_stream { render :index }
      format.html
    end
  end

  def show
    authorize! @post
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build
    publish_now = post_params[:published_at].present?
    result = Posts::Create.call(user: current_user, params: post_params, publish_now: publish_now)

    if result.success?
      @post = result.post
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "Post was successfully created." }
      end
    else
      @post = result.post || Post.new
      flash.now[:alert] = result.error if result.error.present?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! @post
  end

  def update
    authorize! @post

    if @post.update(post_params)
      respond_to do |format|
        format.turbo_stream { render :show }
        format.html { redirect_to @post, notice: "Post was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @post
    @post_id = @post.id
    @post.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Post was successfully deleted." }
    end
  end

  def publish
    authorize! @post, to: :publish?

    result = Posts::Publish.call(post: @post, publisher: current_user)

    respond_to do |format|
      format.turbo_stream { render :show }
      format.html { redirect_to @post, notice: "Post published." }
    end
  end

  def unpublish
    authorize! @post, to: :unpublish?

    result = Posts::Unpublish.call(post: @post)

    respond_to do |format|
      format.turbo_stream { render :show }
      format.html { redirect_to @post, notice: "Post unpublished." }
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
