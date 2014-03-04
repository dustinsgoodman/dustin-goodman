'use strict'

angular.module('dashboardApp')
  .filter 'prettyDate', [() ->
    (input) ->

      if _.isString(input)
        input = parseInt(input)

      diff = (((new Date()).getTime() - input) / 1000)
      dayDiff = Math.floor(diff / 86400)

      if _.isNaN(dayDiff) or dayDiff < 0
        return ""

      dayDiff is 0 and (
        diff < 60 and "just now" or
        diff < 120 and "1 minute ago" or
        diff < 3600 and "#{Math.floor(diff/60)} minutes ago" or
        diff < 7200 and "1 hour ago" or
        diff < 86400 and "#{Math.floor(diff/3600)} hours ago"
      ) or dayDiff is 1 and "Yesterday" or
      dayDiff < 7 and "#{dayDiff} days ago" or
      dayDiff < 31 and "#{Math.ceil(dayDiff/7)} weeks ago" or
      dayDiff < 61 and "1 month ago" or
      dayDiff < 365 and "#{Math.ceil(dayDiff/30)} months ago" or
      "Over a year ago"
  ]