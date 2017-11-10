require "rest-client"

EARTHQUAKE_FEED_URL ="https://haha-4cf04.firebaseio.com/.json"

SCHEDULER.every '4h', :first_in => '0s' do |job|

  #Dummy data if you just want to see it work
  #dummy_data = []
  #10.times {dummy_data << {lat:(32 + rand(18)), long: (-118 + rand(42)), weight: rand(10)}}
  #4.times {dummy_data << {lat:(41 + rand(12)), long: (0 + rand(25)), weight: rand(3)}}

  eq_json_data = RestClient.get EARTHQUAKE_FEED_URL
  raw_data = JSON.parse(eq_json_data)
  real_data = []
  raw_data['todos'].each do |f|
    w=0
    lat = f['lat']
    long = f['long1']
    real_data << {lat: lat, long: long, weight: w}
  end

  send_event('heatmap', { values: real_data })
end