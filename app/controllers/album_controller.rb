class AlbumController < ApplicationController
  def index
    @album = Album.find_by_secret(params[:secret])
    if @album.nil?
      redirect_to :controller => :user, :action => :index
      return
    end
  end

  def new
    if current_user.nil?
      redirect_to :controller => :user, :action => :index
    else
      if request.post?
        # Create album
        @album = current_user.albums.build
        @album.title = params[:title]
        if @album.save
          redirect_to :controller => :album, :action => :index, :secret => @album.secret
          return
        end
      end
    end
  end

  def upload_images
    if request.post?
      @album = current_user.albums.find(params[:album][:id])
      params[:images].each do |img_bin|
        image = @album.images.build
        image.img = img_bin
        image.save
      end
    end
  end
end
