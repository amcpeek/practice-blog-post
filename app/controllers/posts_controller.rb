class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :authorize_author!, only: [ :edit, :update, :destroy ]

  def index
    # Base query: show all published posts, plus current user's unpublished posts
    @posts = if logged_in?
      Post.includes(:author, :categories)
          .where("published_at IS NOT NULL OR author_id = ?", current_user.id)
    else
      Post.includes(:author, :categories)
          .where.not(published_at: nil)
    end

    # Filter by category
    if params[:category_id].present?
      @posts = @posts.joins(:categories).where(categories: { id: params[:category_id] })
    end

    # Filter by author
    if params[:author_id].present?
      @posts = @posts.where(author_id: params[:author_id])
    end

    # Sort order (default: descending/newest first)
    sort_order = params[:sort] == "asc" ? :asc : :desc
    @posts = @posts.order(created_at: sort_order)

    # Load all categories and authors for filter dropdowns
    @categories = Category.order(:name)
    @authors = User.order(:first_name, :last_name)
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
    @categories = Category.order(:name)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to @post
    else
      @categories = Category.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.order(:name)
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully!"
      redirect_to @post
    else
      @categories = Category.order(:name)
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
    params.require(:post).permit(:title, :body, :published_at, category_ids: [])
  end
end
