class Api::MemosController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    memo = Memo.new(create_params)
    unless memo.save
      @error_message = [memo.error.full_messages].compact
    end
  end
  
  def index
    @points = Memo.all.limit('5')
    @hash = Gmaps4rails.build_markers(@points) do |memo, marker|
      marker.lat memo.lat
      marker.lng memo.long
      # marker.infowindow user.description
      # marker.json({title: user.title})
    end
  end
  
  def show
    @points = Memo.all
    @hash = Gmaps4rails.build_markers(@points) do |memo, marker|
      marker.lat memo.lat
      marker.lng memo.long
      # marker.infowindow user.description
      # marker.json({title: user.title})
    end
  end

  private
  def create_params
    params.permit(:lat, :long)
  end
end
