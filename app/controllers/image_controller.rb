class ImageController < ApplicationController
  def index
    @images = Image.all
  end
end
