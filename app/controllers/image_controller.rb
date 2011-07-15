class ImageController < ApplicationController
  def index
    @images = Image.all
  end

  def destroy
    album = Album.find_by_secret(params[:album_secret])
      album.images.destroy(params[:image_id])
    redirect_to :controller => :albums,
      :action => :show,
      :secret => params[:album_secret]
  end
end
