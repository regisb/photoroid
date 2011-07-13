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
    @album = Album.find_by_secret(params[:album][:secret])
    if @album && params[:album][:images]
      params[:album][:images].each{|param|
        image = @album.images.build
        image.img = param
        image.save
      }
      redirect_to :controller => :album, :action => :index, :secret => @album.secret
      return
    end
    redirect_to :controller => :user, :action => :index
  end

  # Asynchronous calls
  def async_big_image
    @album = Album.find_by_secret(params[:album_secret])
    if @album
      @image = @album.images.find_by_id(params[:image_id])
    end
  end

  def async_next_image
    @album = Album.find_by_secret(params[:album_secret])
    if @album
      prev_img = @album.images.find_by_id(params[:image_id])
      next_img = @album.images.first(:conditions => ["taken_at > ?", prev_img.taken_at], :order => "taken_at")
      @image = next_img || @album.images.first
    end
    render "album/async_big_image"
  end

end
