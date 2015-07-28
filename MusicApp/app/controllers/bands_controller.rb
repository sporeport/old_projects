class BandsController < ApplicationController

  def index
    if logged_in?
      @bands = Band.all
      render :index
    else
      flash[:errors] = "please log in or create a user"
      redirect_to users_url
    end
  end

  def show
    if logged_in?
      @band = Band.find(params[:id])
      render :show
    else
      flash[:errors] = "please log in or create a user"
      redirect_to users_url
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = "I don't know how you messed that up..."
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      redirect_to bands_url
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
