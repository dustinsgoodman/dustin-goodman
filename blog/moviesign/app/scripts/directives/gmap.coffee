'use strict';

angular.module('dashboardApp')
  .directive 'gmap', [->
    template: '<div></div>'
    restrict: 'EA'
    replace: true
    scope:
      locs: '='
      opts: '='
      loc: '='
    link: (scope, element, attrs) ->
      google.maps.visualRefresh = true

      # console.log("Map scope", scope)
      if scope.locs
        # console.log("Using locs")
        locations = scope.locs
      else
        if scope.loc
          # console.log("Using single location")
          locations = [scope.loc]

      if locations?
        if locations[0]?
          minLat = maxLat = locations[0][0]
          minLng = maxLng = locations[0][1]
        else
          maxLat = 33.916783
          minLat = 33.61689
          maxLng = -84.216758
          minLng = -84.483378

        map = new google.maps.Map(element[0], scope.opts)

        infowindow = new google.maps.InfoWindow()

        _.chain(locations)
          .filter((loc) -> loc[0] isnt 0 and loc[1] isnt 1)
          .each (loc) ->
            minLat = loc[0] if loc[0] < minLat
            maxLat = loc[0] if loc[0] > maxLat
            minLng = loc[1] if loc[1] < minLng
            maxLng = loc[1] if loc[1] > maxLng
            new google.maps.Marker
              position: new google.maps.LatLng loc[0], loc[1]
              map: map

        initial_bounds = true

        check_initial_bounds = () ->
          if initial_bounds
            initial_bounds = false
            # console.log("Checking initial bounds at zoom level:" + map.getZoom())
            # Set a maximum reasonable zoom level
            if map.getZoom() > 15
              map.setZoom(15)

        google.maps.event.addListener(map, "bounds_changed", check_initial_bounds)

        map.fitBounds(new google.maps.LatLngBounds(
          new google.maps.LatLng(minLat, minLng),
          new google.maps.LatLng(maxLat, maxLng)))


        # console.log("Map zoom:" + map.getZoom())

        google.maps.event.addListener(map, "zoom_changed", () ->
          # console.log("Map zoom changed:" + map.getZoom())
        )
      null
  ]
