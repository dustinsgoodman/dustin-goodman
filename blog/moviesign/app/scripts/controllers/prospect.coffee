'use strict'

angular.module('dashboardApp').controller('ProspectCtrl', [
    '$scope'
    '$location'
    '$timeout'
    '$filter'
    'Routes'
    'Auth'
    'StreamParser'
    'prospect'
    'profile'
    'notes'
    'agents'
    'locations'
    ($scope, $location, $timeout, $filter, Routes, Auth, StreamParser, prospect, profile, notes, agents, locations) ->
        # Status Tools
        $scope.statuses = globals.prospect.status
        $scope.updateStatus = () ->
            Routes.prospects($scope.prospect.prospectId).post('status', {status: $scope.prospect.status})

        # Grade Tools
        $scope.$watch("prospect.grade", (newVal, oldVal) ->
            if newVal isnt oldVal
                # console.log("Got #{newVal} for prospect grade, replacing #{oldVal}")
                if newVal?
                    Routes.prospects($scope.prospect.prospectId).post('grade', {grade: newVal})
                else
                    Routes.prospects($scope.prospect.prospectId).one('grade').remove()
        )
        $scope.clearGrade = () ->
            $scope.prospect.grade = null

        # Assignment Tools
        $scope.agents = agents
        $scope.assignAgent = (agent) ->
            Routes.admin().one('prospects', $scope.prospect.prospectId).post('assignment', {userId: $scope.agent.userId})

        # Notes Tools
        $scope.notes = _.sortBy(notes.data, (note) -> -note.timestamp)
        $scope.addNote = (newNote) ->
            Routes.prospects($scope.prospect.prospectId).post('notes', {note: newNote}).then((resp) ->
                $scope.notes.unshift(resp.data)
                $scope.newNote = ""
            )
        $scope.removeNote = (noteId, idx) ->
            Routes.prospects($scope.prospect.prospectId).one('notes', noteId).remove()
            $scope.notes.splice(idx, 1)

        $scope.prospect = prospect

        # Profile Existent Depedent Features
        if profile? and not _.isEmpty(profile)
          $scope.profile = profile.profile

          # Most Viewed Property
          $scope.mostViewedProperty = $scope.profile.profile.property.mostViews.propertyInfo
          $scope.mostViewedPropertyCount = $scope.profile.profile.property.mostViews.viewCount
          if not $scope.mostViewedProperty? or _.isEmpty($scope.mostViewedProperty.photos)
              $scope.photos = [globals.noPhoto]
          else
              $scope.photos = $scope.mostViewedProperty.photos

          # Graphs and Maps
          # Graphs
          $scope.propertyViewCounts = $scope.profile.profile.viewCounts
          stats = $scope.profile.profile.stats

          $scope.beds = _.object(_.map(stats.beds, (bed) -> "#{bed.beds} Beds"), _.map(stats.beds, (bed) -> bed.viewCount))
          $scope.fbaths = _.object(_.map(stats.fullBaths, (fb) -> "#{fb.fullBaths} Full Baths"), _.map(stats.fullBaths, (fb) -> fb.viewCount))

          _.each(stats.priceDistribution, ((v,k) ->
              this[$filter('noDecimalCurrency')(k)] = v
              delete this[k]
          ), stats.priceDistribution)
          $scope.prices = [["Price", "Count"]].concat(_.pairs(stats.priceDistribution))

        # Map
        $scope.mapOpts = globals.google.mapOpts
        $scope.locations = locations

        # Activity Streams
        INIT = 0
        POLLER = 1
        HISTORY = 2

        $scope.feeds = [
            {
                title: "Property Views"
                stream: []
                ctrl: "property-views"
                from: 0
                to: 0
                max: 0
            }, {
                title: "Searches"
                stream: []
                ctrl: "searches"
                from: 0
                to: 0
                max: 0
            }, {
                title: "Inquiries"
                stream: []
                ctrl: "inquiries"
                from: 0
                to: 0
                max: 0
            }, {
                title: "Saved Searches"
                stream: []
                ctrl: "saved-searches"
                from: 0
                to: 0
                max: 0
            }, {
                title: "Watch Lists"
                stream: []
                ctrl: "watch-lists"
                from: 0
                to: 0
                max: 0
            }
        ]

        getHeaderVals = (headers, dir, feed) ->
            if headers? and headers['content-range']?
                [from, to, max] = _.map(headers['content-range'].match(/\d+/g), (v) -> parseInt(v))
                switch dir
                    when INIT
                        [feed.from, feed.to, feed.max] = [from, to, max]
                    when POLLER
                        [feed.to, feed.max] = [to, max]
                    when HISTORY
                        feed.from = from
            return

        poller = () ->
            if Auth.user.userId is 0 or not (/\/prospect\/\d+/g).test($location.path())
                return
            _.each($scope.feeds, (feed) ->
                headers = if feed.max is 0 then {} else {"Range": "resources=#{feed.max+1}-"}
                processFeed(feed, POLLER, headers)
            )
            $timeout(poller, 10000)
            return


        processFeed = (feed, dir, headers) ->
            headers = {} if not headers?
            Routes.prospects(prospect.prospectId, feed.ctrl).getList({}, headers).then((stream) ->
                getHeaderVals(stream.headers(), dir, feed)
                newStream = _.chain(StreamParser.rollupOld(stream.data))
                    .map((e) ->
                        if _.isArray(e)
                            [count, e] = [e.length, e[0]]
                            _.extend(e, {count: count})
                        else
                            e)
                    .filter((e) -> StreamParser.processProfileEvent(e)?)
                    .value()
                switch dir
                    when INIT
                        feed.stream = newStream
                    when POLLER
                        feed.stream = newStream.concat(feed.stream)
                    when HISTORY
                        feed.stream = feed.stream.concat(newStream)
            )
            return

        # Initialize Feeds
        _.each($scope.feeds, (feed) -> processFeed(feed, INIT))
        $timeout poller, 10000
])
