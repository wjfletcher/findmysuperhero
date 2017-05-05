class Api::V1::HeroesController < ApplicationController
  def index
    @coordinates = {
      "NYC" => [40.730610, -73.935242],
      "Boston" => [42.364506, -71.038887],
      "DC" => [38.894207, -77.035507],
      "Chicago" => [41.881832, -87.623177],
      "Indianapolis" => [39.832081, -86.145454],
      "LA" => [34.052235, -118.243683],
      "SF" => [37.733795, -122.446747],
      "Dallas" => [32.897480, -97.040443],
      "Denver" => [39.742043, -104.991531],
      "Seattle" => [47.608013, -122.335167],
      "New Orleans" => [29.951065, -90.071533],
      "Orlando" => [28.538336, -81.379234],
      "Baltimore" => [39.299236, -76.609383],
      "Minneapolis" => [44.986656, -93.258133],
      "Cleveland" => [41.505493, -81.681290]
    }

    require "redis"
    redis = Redis.new

    # Check if redis database already created
    if !redis.exists("Heroes")
      privatekey = 'fb6937288c9b5379a7cb858862f553dfec285e26'
      publickey = '11998b6ebf4dee2e0de00a3a55496d81'
      timestamp = Time.now.to_i.to_s
      hash = Digest::MD5.hexdigest(timestamp + privatekey + publickey)

      # get all heroes by running 15 api requests since there are about 1500 heroes
      @heroes = []
      offset = 0
      15.times do
        heroestemp = parseparty("http://gateway.marvel.com/v1/public/characters?limit=100&offset=#{offset}&ts=#{timestamp}&apikey=#{publickey}&hash=#{hash}")
        @heroes << heroestemp["data"]["results"][0]
        offset += 100
      end
      @heroes.sort_by! {|heroes| heroes["comics"]["available"].to_i}.reverse!

      # link each hero to a coordinate
      herocount = 0
      @coordinates.each do |city, coord|
        redis.geoadd("Heroes", coord[1], coord[0], @heroes[herocount]["name"])
        herocount += 1
      end
    end

    # find heroes near Boston using georadius
    @heroesnearboston = redis.georadius("Heroes", @coordinates["Boston"][1], @coordinates["Boston"][0], "500", "mi", "withdist", "asc")
    render json: {heroesnearboston: @heroesnearboston}


  end

  def parseparty(url)
    call = HTTParty.get(url)
    JSON.parse(call.body)
  end
end
