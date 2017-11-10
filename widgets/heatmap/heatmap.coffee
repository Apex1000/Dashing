class Dashing.Heatmap extends Dashing.Widget
  @accessor 'values'

  ready: ->
    @onData(this)


  parseData = (raw_data) ->
    pdata = (for d in raw_data.values
      location: new google.maps.LatLng(d.lat, d.long), weight: (d.weight ? 1)
      )

  onData: (data) ->
    # Handle incoming data
    if(!data)
      data = @get("values")
    if(!data)
      return

    parsed_data = parseData(data)

    mtype = switch @get('mapType')
      when "TERRAIN" then google.maps.MapTypeId.TERRAIN
      when "HYBRID" then google.maps.MapTypeId.HYBRID
      when "ROADMAP" then google.maps.MapTypeId.ROADMAP
      else google.maps.MapTypeId.SATELLITE

    mapOptions = {
      zoom: (@get('zoom') ? 15)
      center: new google.maps.LatLng((@get('centerLat') ? 23.54567318), (@get('centerLong') ? 87.28209403))
      mapTypeId: mtype
      zoomControl: true
      panControl: true
      streetViewControl: true
      scrollwheel: true
      disableDoubleClickZoom: true
      draggable: true
      mapTypeControl: true
    }
    map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions)
    pointArray = new google.maps.MVCArray(parsed_data);
    heatmap = new google.maps.visualization.HeatmapLayer({data: pointArray})
    heatmap.setMap(map)
    # You can access the html node of this widget with `@node`
    $(@node).fadeOut().fadeIn()
