'use strict'

angular.module('dashboardApp').directive('searchedProperties', [() ->
    templateUrl: '/views/feed-item/prospect-searched-properties.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.search = scope.feedItem.search
        scope.prospect = scope.feedItem.prospectInfo
        scope.count = scope.feedItem.count
        scope.time = scope.feedItem.time
        scope.view = scope.view

        verify = (x) ->
            x? and not _.isEmpty(x)

        searchSummary = (search) ->
            ret = []
            if verify(search.query)
                ret.push search.query
            else if verify(search.subdivision) and verify(search.city) and verify(search.state)
                ret.push search.subdivision
                ret.push search.city
                ret.push search.state
            else if verify(search.city) and verify(search.state) and verify(search.zip)
                ret.push search.city
                ret.push "#{search.state} #{search.zip}"
            else if verify(search.county) and verify(search.state)
                ret.push search.county
                ret.push search.state
            else if verify(search.zip)
                ret.push search.zip
            else if verify(search.schools)
                ret.push search.schools
            else if verify(search.county)
                ret.push search.county
            else if search.location?
                return "map"
            else if verify(search.state)
                ret.push search.state
            return _.flatten(ret)

        scope.getMapLink = (coords) ->
            mapLink = "http://maps.google.com/maps/api/staticmap?size=200x200&maptype=roadmap&format=jpg&sensor=false"
            if coords.length is 4
                [lat1, lng1, lat2, lng2] = coords
                latCenter = (lat1 + lat2) / 2
                lngCenter = (lng1 + lng2) / 2
                mapLink += "&center=#{latCenter},#{lngCenter}&path=color:0xff0000ff|weight:2|#{lat1},#{lng1}|#{lat2},#{lng1}|#{lat2},#{lng2}|#{lat1},#{lng2}|#{lat1},#{lng1}"
            else if coords.length is 3
                [lat, lng, dist] = coords
                lat = (lat * Math.PI) / 180
                lng = (lng * Math.PI) / 180
                dist = dist / 6371
                points = []
                _.each([0...360], (i) ->
                    brng = i * Math.PI / 180
                    pLat = Math.asin(Math.sin(lat) * Math.cos(dist) + Math.cos(lat) * Math.sin(dist) * Math.cos(brng))
                    pLng = ((lng + Math.atan2(Math.sin(brng) * Math.sin(dist) * Math.cos(lat), Math.cos(dist) - Math.sin(lat) * Math.sin(pLat))) * 180) / Math.PI
                    pLat = (pLat * 180) / Math.PI

                    points.push([pLat, pLng])
                )

                pathEncString = google.maps.geometry.encoding.encodePath(points)
                mapLink += "&center=#{lat},#{lng}&path=fillcolor:0xff0000ff|weight:1|color:0xFFFFFF|enc:#{pathEncstring}"
            return mapLink

        summary = searchSummary(scope.search)
        if verify(summary)
            if _.isArray(summary)
                scope.summaryDetails = "ran a search for <span class='bolder'>#{summary.join(', ')}</span>."
            else if _.isString(summary) and summary is 'map'
                scope.summaryDetails = "ran a map search."
            else
                scope.summaryDetails = "ran a search. It was pointless."
        else
            scope.summaryDetails = "ran a search. It was pointless."

        if parseInt(scope.view) isnt 0
            scope.summaryDetails = scope.summaryDetails.charAt(0).toUpperCase() + scope.summaryDetails.substring(1)

        return
])