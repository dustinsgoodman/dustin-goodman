'use strict'

angular.module('dashboardApp')
  .controller('ListingCtrl', [
    '$scope'
    '$location'
    '$timeout'
    'Routes'
    'Auth'
    'StreamParser'
    'listing'
    ($scope, $location, $timeout, Routes, Auth, StreamParser, listing) ->
      $scope.mapOpts = globals.google.mapOpts

      $scope.listing = listing
      $scope.listing_keys = _.keys(listing).sort()
      if listing.property.latitude? && listing.property.longitude
        $scope.loc = [listing.property.latitude, listing.property.longitude]
      if _.isEmpty(listing.photos)
        $scope.photos = [globals.noPhoto]
      else
        $scope.photos = listing.photos
  ])