#!/usr/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'json'

weather_msg = ""
open('http://api.wunderground.com/api/KEY/forecast10day/q/94131.json') do |f|
	json_string = f.read
	parsed_json = JSON.parse(json_string)
	if Time.now().hour() > 17
		weather_msg += parsed_json['forecast']['txt_forecast']['forecastday'][1]['fcttext']
	else
		weather_msg += parsed_json['forecast']['txt_forecast']['forecastday'][0]['fcttext']
	end
end

#zmw:84101.1.99999
#locid:01613388

snow_msg = "Snow coming! "

open('http://api.wunderground.com/api/KEY/forecast10day/q/locid:01613388.json') do |f|
  json_string = f.read
  parsed_json = JSON.parse(json_string)
  
  parsed_json['forecast']['simpleforecast']['forecastday'].each { |day|
  	if day['snow_allday']['in'] > 0
  		output_msg += "#{day['date']['monthname_short']} #{day['date']['day']}: #{day['snow_allday']['in']}\" "
  		snow_coming = 1
  	end
  }
  if snow_msg == "Snow coming! "
  	snow_msg = "No snow in forecast :-("
  end
end

begin
  file = File.open("/var/www/ledmsg.txt", "w")
  file.write(weather_msg + " " + snow_msg)
rescue IOError => e
  puts "file writing error"
ensure
  file.close unless file == nil
end
