class SubsController < ApplicationController
  def index
    @subs = Sub.all.includes(:moderator).order(:updated_at)
  end

  def show
    @sub = Sub.includes(:moderator, :posts).find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)

    if @sub.save
      flash[:notice] = ["Your subReddit has successfully \
                        been created"]
      redirect_to sub_url(@sub)
    else
      flash[:danger] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = current_user.moderated_subs.find(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = ["Your subReddit has been successfully edited"]
      redirect_to sub_url(@sub)
    else
      flash[:danger] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = current_user.moderated_subs.find(params[:id]).destroy
    flash[:notice] = ["#{@sub.title} has been deleted."]
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
