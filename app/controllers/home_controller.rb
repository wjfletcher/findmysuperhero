class HomeController < ApplicationController
  def index
  end

  def create
    require "redis"
    redis = Redis.new

    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @location = params[:location]
    @distance = params[:distance]
    @heroesnearlocation = redis.georadius("Heroes", @longitude, @latitude, @distance, "mi", "withdist", "asc")
    render "home/index"
  end

  def coordinate_params
    params.require(:home).permit(
      :latitude,
      :longitude,
      :location,
      :distance
    )
  end
end
