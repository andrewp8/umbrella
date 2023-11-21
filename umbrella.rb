require "http"
require "json"

gmap_api = ENV.fetch("GMAPS_KEY")
weather_api = ENV.fetch("PIRATE_WEATHER_KEY")

# location = gets.chomp.gsub(" ","%20")
location = "Chicago"
gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20"+location+"&key="+gmap_api

raw_response =  HTTP.get(gmap_url).to_s
parsed_response = JSON.parse(raw_response)
gmap_location_result = parsed_response.fetch("results").at(0).fetch("geometry").fetch("location")
lat = gmap_location_result.fetch("lat")
lng = gmap_location_result.fetch("lng")

weather_url = "https://api.pirateweather.net/forecast/"+weather_api+"/"+ lat.to_s + ","+ lng.to_s

pp HTTP.get(weather_url)
