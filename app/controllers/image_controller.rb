class ImageController < ApplicationController
  def index
    @images = Image.all
  end

  def destroy
    if request.delete?
      album = Album.find_by_secret(params[:album_secret])
      if album
        image = album.images.find_by_id(params[:image_id])
        image.destroy if image
      end
    end
    redirect_to :controller => :album, 
      :action => :index, 
      :secret => params[:album_secret]
  end
end
