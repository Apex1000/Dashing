class Dashing.Dynamap extends Dashing.Widget
  json_path = 'https://s3-us-west-2.amazonaws.com/samnco-static-files/country-maps/countries.jsonp'
  json_countries = null
  plots = []

  jsonCountriesLoader = (url) ->
    $.ajax
      'jsonpCallback':"jsonCountriesLoader"
      'contentType':"application/json"
      'async': false
      'global': false
      'url': url
      'dataType': "jsonp"
      'success':  (data) -> 
        json_countries = data
     return json_countries
     
  newCountry = (req_country) ->
    json_countries = jsonCountriesLoader json_path
    json_countries.countries.forEach( (country) ->
      if country.name.common == req_country
        name = country.name.common
        coordinates = country.latlng
        lat = coordinates[0]
        long = coordinates[1]
        plots.push { "name": name, "lat": lat, "long": long, "weight": 1 }
    )

  plotCountries = (plot_array) ->
    for d in plot_array
      location: new google.maps.LatLng(d.lat, d.long), weight: (d.weight)
    
  ready: ->
    mtype = switch @get('mapType')
      when "TERRAIN" then google.maps.MapTypeId.TERRAIN
      when "HYBRID" then google.maps.MapTypeId.HYBRID
      when "ROADMAP" then google.maps.MapTypeId.ROADMAP
      else google.maps.MapTypeId.ROADMAP

    mapOptions = {
      zoom: (@get('zoom') ? 1)
      center: new google.maps.LatLng((@get('centerLat') ? 20), (@get('centerLong') ? -102.5))
      mapTypeId: mtype
      zoomControl: false
      panControl: false
      streetViewControl: false
      scrollwheel: false
      disableDoubleClickZoom: false
      draggable: true
      mapTypeControl: false
    }

    new_map = plotCountries(plots)
    map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions)
    pointArray = new google.maps.MVCArray(new_map)
    heatmap = new google.maps.visualization.HeatmapLayer({data: pointArray})
    heatmap.setMap(map)

    @onData(plots)

  onData: (data) ->
    if(!data)
      data = plots
    if(!data)
      return

    country = @get('country')
    newCountry(country)
    new_map = plotCountries(plots)

    mtype = switch @get('mapType')
      when "TERRAIN" then google.maps.MapTypeId.TERRAIN
      when "HYBRID" then google.maps.MapTypeId.HYBRID
      when "ROADMAP" then google.maps.MapTypeId.ROADMAP
      else google.maps.MapTypeId.ROADMAP

    mapOptions = {
      zoom: (@get('zoom') ? 1)
      center: new google.maps.LatLng((@get('centerLat') ? 20), (@get('centerLong') ? -102.5))
      mapTypeId: mtype
      zoomControl: false
      panControl: false
      streetViewControl: false
      scrollwheel: false
      disableDoubleClickZoom: false
      draggable: true
      mapTypeControl: false
    }

    map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions)
    pointArray = new google.maps.MVCArray(new_map)
    heatmap = new google.maps.visualization.HeatmapLayer({data: pointArray})
    heatmap.setMap(map)
    $(@node).fadeOut().fadeIn()