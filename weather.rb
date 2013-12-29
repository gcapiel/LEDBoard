#!/usr/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'json'


output_msg = "Snow coming! "

open('http://api.wunderground.com/api/KEY/forecast10day/q/locid:01613388.json') do |f|
  json_string = f.read
  parsed_json = JSON.parse(json_string)
  
  parsed_json['forecast']['simpleforecast']['forecastday'].each { |day|
  	if day['snow_allday']['in'] > 0
  		output_msg += "#{day['date']['monthname_short']} #{day['date']['day']}: #{day['snow_allday']['in']}\" "
  		snow_coming = 1
  	end
  }
  if output_msg == "Snow coming! "
  	output_msg = "No snow in forecast :-("
  end
end

begin
  file = File.open("/var/www/ledmsg.txt", "w")
  file.write(output_msg)
rescue IOError => e
  puts "file writing error"
ensure
  file.close unless file == nil
end
