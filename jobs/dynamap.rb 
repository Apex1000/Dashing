require "rest-client"

COUNTRY_LOCATIONS_URL="https://s3-us-west-2.amazonaws.com/samnco-static-files/country-maps/countries.json"
COUNTRY_LOCATIONS = RestClient.get COUNTRY_LOCATIONS_URL


SCHEDULER.every '10s', :first_in => '0s' do |job|
  index = rand(1000)
  countries = JSON.parse(COUNTRY_LOCATIONS)
  countries['countries'].each do |f|
    if f['ccn3'].to_i == index
      country_name = f['name']['common']
      send_event('dynamap', { country: country_name } )
      break
    end
  end
end