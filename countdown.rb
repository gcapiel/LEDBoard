#!/usr/bin/env ruby

require 'time'
require 'net/http'

if (DateTime.now.to_time.utc + Time.zone_offset("PDT")).to_datetime.mday() == 3 then
	diff = 18*60+39-((DateTime.now.to_time.utc + Time.zone_offset("PDT")).to_datetime.hour()*60+(DateTime.now.to_time.utc + Time.zone_offset("PDT")).to_datetime.min())
else
		diff = 18*60+39 + ((24*60) - ((DateTime.now.to_time.utc + Time.zone_offset("PDT")).to_datetime.hour()*60+(DateTime.now.to_time.utc + Time.zone_offset("PDT")).to_datetime.min()))
end

if diff > 0 then
	msg = URI::encode("DETA #{(diff/60).to_i}:%02d" % (diff-(diff/60).to_i*60))
	msg = msg + "%20xoxo"
else
	msg = "The%20toucan%20lands"
end

puts msg
puts Net::HTTP.get(URI.parse("http://192.168.1.147/led.php?msg=#{msg}"))
