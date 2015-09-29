class WeathersController < ApplicationController

  def index
    city = params[:city] || "Chicago"
    state = params[:state] || "IL"
    @weather = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
    @current_weather = @weather["query"]["results"]["channel"]["item"]["condition"]["temp"]
    @forecasts = @weather["query"]["results"]["channel"]["item"]["forecast"]
    @fahrenheit = @weather["query"]["results"]["channel"]["units"]["temperature"]
    @city = @weather["query"]["results"]["channel"]["location"]["city"]
    @country = @weather["query"]["results"]["channel"]["location"]["country"]
    @description = @weather["query"]["results"]["channel"]["item"]["description"]
  end
end
