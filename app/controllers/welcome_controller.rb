class WelcomeController < ApplicationController
  def index
  @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

  response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")

  if params[:city] != nil
    params[:city].gsub!(" ", "_")
  end

  if params[:state] != "" && params[:city] != ""
    if params[:state] != nil && params[:city] != nil
      response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    end
  else
    response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
  end


  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather']
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel_f = response['current_observation']['feelslike_f']
  @real_feel_c = response['current_observation']['feelslike_c']

  if @weather_words == "Overcast"
    	@url = "http://cloud-maven.com/wp-content/uploads/2014/08/DSC_0367.jpg"
    elsif @weather_words == "Clear"
    	@url = "https://hd.unsplash.com/photo-1466837838619-c8f5b8f0c166.jpg"
    elsif @weather_words == "Partly Cloudy"
    	@url = "http://wallpoper.com/images/00/44/82/22/cloudy_00448222.jpg"
    elsif @weather_words == "Mostly Cloudy"
    	@url = "https://hd.unsplash.com/photo-1457903685934-249e8108a246.jpg"
    elsif @weather_words == "Snow"
    	@url = "http://host2post.com/server13/photos/S1H-6hjE6S1FUM~/wallpapers-trees-full-snow-cold-weather-december-mountains.jpg"
    else 
    	@url = "http://wallpoper.com/images/00/44/71/54/rainy-weather_00447154.jpg"
    end
  end

  def test
  	response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
  
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @real_feel_f = response['current_observation']['feelslike_f']
    @real_feel_c = response['current_observation']['feelslike_c']
  end
end


