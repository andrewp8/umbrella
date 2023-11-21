require "http"
require "json"

#GMAP & WEATHER APIS
gmap_api = ENV.fetch("GMAPS_KEY")
weather_api = ENV.fetch("PIRATE_WEATHER_KEY")

# GET LOCATION INPUT
puts "Where are you located?"
location = gets.chomp.gsub(" ","%20")

# ======GMAP DATA======
gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20"+location+"&key="+gmap_api
gmap_raw_response =  HTTP.get(gmap_url).to_s
gmap_parsed_response = JSON.parse(gmap_raw_response)
gmap_location_result = gmap_parsed_response.fetch("results").at(0).fetch("geometry").fetch("location")
lat = gmap_location_result.fetch("lat")
lng = gmap_location_result.fetch("lng")

# ======WEATHER DATA======
weather_url = "https://api.pirateweather.net/forecast/"+weather_api+"/"+ lat.to_s + ","+ lng.to_s
weather_raw_response = HTTP.get(weather_url).to_s
weather_parsed_response = JSON.parse(weather_raw_response)

current_temp =  weather_parsed_response.fetch("currently").fetch("temperature")
weather_data = weather_parsed_response.fetch("hourly").fetch("data")
next_hr_summary = weather_data[1].fetch("summary")
# pp next_hr_summary
# time_now = Time.now
# pp Time.at(time_now.to_i)
over_10_percent = false
puts "Checking the weather at Chicago..."
puts "Your coordinates are #{lat}, #{lng}"
puts "It is currently #{current_temp}\u00B0F"
puts "Next hour: #{next_hr_summary}"
weather_data[1,12].each_with_index{|hourly, idx| precip_prob = hourly.fetch("precipProbability")*100

  if precip_prob > 10
    # what if there is one hour's precip_prob < 10, line 44 won't we executed. 
    over_10_percent = true
    puts "In #{idx+1} hours, there is a #{precip_prob}% chance of preciptation."
  end
}
puts over_10_percent == true ? "You might want to carry an umbrella!" : "You probably won't need an umbrella today."
