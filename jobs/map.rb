# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1s', :first_in => 0 do |job|
  send_event('map', { markers: [[40.7042711, -73.99463564],[40.72068318, -74.0360876],[40.69018566, -73.99902579],[40.71371072, -74.00686788]] })
end
