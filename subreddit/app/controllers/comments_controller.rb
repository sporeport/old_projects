class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

    @comment.author_id = current_user.id

    if @comment.save
      flash[:notice] = ["comment was successfully created!"]
      redirect_to post_url(@post)
    else
      flash.now[:danger] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
