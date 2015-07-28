class AlbumsController < ApplicationController

  def show
    if logged_in?
      flash[:errors] = "please log in or create a user"
      redirect_to users_url
    else
      @album = Album.find(params[:id])
      render :show
    end
  end

  def new
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    temp = @album.destroy
    redirect_to band_url(temp.band)
  end

  private

  def album_params
    params.require(:album).permit(:name, :album_type, :band_id)
  end
end
