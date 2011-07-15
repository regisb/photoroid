class ImageController < ApplicationController
  def index
    @images = Image.all
  end

  def destroy
    image = current_user.images.find(params[:id])
    album = image.album
    image.destroy
    redirect_to :controller => :albums, 
      :action => :show,
      :secret => album.secret
  end
end
