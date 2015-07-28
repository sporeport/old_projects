class TracksController < ApplicationController
  def show
    if logged_in?
      flash[:errors] = "please log in or create a user"
      redirect_to users_url
    else
      @track = Track.find(params[:id])
      render :show
    end
  end

  def new
    @albums = Album.all
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      @albums = Album.all
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    temp = @track.destroy
    redirect_to album_url(temp.album)
  end

  def edit
    @albums = Album.all
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to album_url(@track.album_id)
    else
      flash[:errors] = @track.errors.full_messages
      @albums = Album.all
      render :edit
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :track_num, :album_id, :song_type, :lyrics)
  end
end
