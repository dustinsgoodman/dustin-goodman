'use strict'

angular.module('dashboardApp').controller('DashboardCtrl', [
    '$scope'
    '$timeout'
    '$location'
    'Routes'
    'Auth'
    'StreamParser'
    'dashboard'
    ($scope, $timeout, $location, Routes, Auth, StreamParser, dashboard) ->
        INIT = 0
        POLLER = 1
        HISTORY = 2

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
            if Auth.user.userId is 0 or $location.path() isnt '/'
                return
            _.each($scope.feeds, (feed) ->
                switch feed.ctrl
                    when "activity"
                        headers = {"Range": "resources=#{feed.to+1}-"} if feed.max isnt 0
                        processActivityFeed(feed, POLLER, headers)
                    when "top-prospects", "hot-prospects"
                        processScoreFeed(feed, POLLER)
            )
            $timeout(poller, 10000)
            return

        $scope.getHistory = (feed, getX) ->
            if feed.from is 0
                return

            from = if feed.from <= (getX + 1) then 0 else (feed.from - getX)
            to = feed.from - 1
            headers = {"Range": "resources=#{from}-#{to}"}
            switch feed.ctrl
                when "activity"
                    processActivityFeed(feed, HISTORY, headers)
                when "top-prospects", "hot-prospects"
                    processScoreFeed(feed, HISTORY)
            return

        processActivityFeed = (feed, dir, headers) ->
            headers = {} if not headers?
            Routes.feed(Auth.user.userId, feed.ctrl).getList({}, headers).then((stream) ->
                getHeaderVals(stream.headers(), dir, feed)
                newStream = _.chain(StreamParser.rollup(stream.data))
                    .map((e) ->
                        if _.isArray(e)
                            [count, e] = [e.length, e[0]] 
                            _.extend(e, {count: count})
                        else
                            e)
                    .filter((e) -> StreamParser.processDashboardEvent(e)?)
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

        processScoreFeed = (feed, dir, headers) ->
            Routes.feed(Auth.user.userId, feed.ctrl).getList().then((stream) ->
                getHeaderVals(stream.headers(), dir, feed)
                newStream = _.map(stream.data, (e) ->
                    _.extend(e, {type: feed.ctrl})
                )

                switch dir
                    when INIT, POLLER
                        feed.stream = newStream
            )
            return

        # initialize feed streams
        $scope.feeds = _.map(dashboard.data, (feed) ->
            _.extend(
                _.pick(feed, 'title', 'stream', 'ctrl'),
                {to: 0, from: 0, max: 0}
            )
        )

        # start filling streams
        _.each($scope.feeds, (feed) ->
            switch feed.ctrl
                when "activity"
                    processActivityFeed(feed, INIT)
                when "top-prospects", "hot-prospects"
                    processScoreFeed(feed, INIT)
        )
        $timeout(poller, 10000)
])