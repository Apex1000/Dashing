require 'nokogiri'
require 'open-uri'
require "rest-client"

EARTHQUAKE_FEED_URL ="https://haha-4cf04.firebaseio.com/.json"
# source = "https://haha-4cf04.firebaseio.com/.json"

labels = ['1','2','3','4','5','6','7','8','9']
i=0
SCHEDULER.every '10s', :first_in => '0' do |job|
  eq_json_data = RestClient.get EARTHQUAKE_FEED_URL
  raw_data = JSON.parse(eq_json_data)
  real_data = []
  raw_data['todos1'].each do |f|
    sound = f['sound']
    real_data << [sound]
    end
    # current_valuation=lat
    data = [
    {
      label: 'First dataset',
      data: Array.new(labels.length) { real_data[i] },
      backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * labels.length,
      borderColor: [ 'rgba(255, 99, 132, 1)' ] * labels.length,
      borderWidth: 1,
    }
  ]
    send_event('linechart', { labels: labels, datasets: data })
i=i+1
end