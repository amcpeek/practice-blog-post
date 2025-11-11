class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :require_login
  before_action :authorize_author!, only: [ :edit, :update, :destroy ]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      flash[:notice] = "Comment added successfully!"
      redirect_to @post
    else
      flash[:alert] = "Could not add comment: #{@comment.errors.full_messages.join(', ')}"
      redirect_to @post
    end
  end

  def edit
    # Edit form rendered inline or on separate page
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully!"
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted successfully."
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_author!
    authorize_user!(@comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
