class Api::MemosController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    memo = Memo.new(create_params)
    unless memo.save
      @error_message = [memo.error.full_messages].compact
    end
  end
  
  def res
    # y = Memo.pluck(:lat)[0]
    # x = Memo.pluck(:long)[0]
    # uri = URI("http://geoapi.heartrails.com/api/json")
    # uri.query = URI.encode_www_form({ method: "searchByGeoLocation", x: x, y: y })
    # res = Net::HTTP.get_response(uri)
    # json = JSON.parse(res.body)
    # puts json

  end
  
  def index
  end
  
  def map
    @points = Memo.all.limit('1').order('created_at DESC')
    @hash = Gmaps4rails.build_markers(@points) do |memo, marker|
      marker.lat memo.lat
      marker.lng memo.long
    end
    y = Memo.order('created_at DESC').pluck(:lat)[0]
    x = Memo.order('created_at DESC').pluck(:long)[0]
    uri = URI("http://geoapi.heartrails.com/api/json")
    uri.query = URI.encode_www_form({ method: "searchByGeoLocation", x: x, y: y })
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body)
    # puts json
    @city = json["response"]["location"][0]["city"]
    @town = json["response"]["location"][0]["town"]
      # marker.infowindow user.description
      # marker.json({title: user.title})
    
  end

  private
  def create_params
    params.permit(:lat, :long)
  end
end
