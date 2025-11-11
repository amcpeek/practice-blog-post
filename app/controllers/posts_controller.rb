class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :authorize_author!, only: [ :edit, :update, :destroy ]

  def index
    # Show all published posts, plus current user's unpublished posts
    @posts = if logged_in?
      Post.includes(:author)
          .where("published_at IS NOT NULL OR author_id = ?", current_user.id)
          .order(created_at: :desc)
    else
      Post.includes(:author)
          .where.not(published_at: nil)
          .order(created_at: :desc)
    end
  end

  def show
    # Check if user can view unpublished post
    if @post.published_at.nil? && (!logged_in? || @post.author != current_user)
      flash[:alert] = "That post is not published yet."
      redirect_to root_path
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully!"
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted successfully."
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.includes(:author, comments: :author).find(params[:id])
  end

  def authorize_author!
    authorize_user!(@post)
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
