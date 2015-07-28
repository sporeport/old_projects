class PostsController < ApplicationController
  def show
    @post = Post
      .includes(:author, :subs, { :comments => :author } )
      .find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = ["Your post was successfully created"]
      redirect_to post_url(@post)
    else
      flash.now[:danger] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = ["Your post was successfully updated"]
      redirect_to post_url(@post)
    else
      flash.now[:danger] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
