'use strict'

describe 'Controller: ProspectCtrl', () ->
  scope = ProspectCtrl = DataParser = null

  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, _DataParser_) ->
      scope = $rootScope.$new()
      ProspectCtrl = $controller 'ProspectCtrl',
        $scope: scope
      DataParser = _DataParser_

  it 'should provide a user', ->
    expect(scope.user instanceof Object).toBeTruthy()

  it 'should provide an array of lng/lat pairs', ->
    expect(scope.locations instanceof Array).toBeTruthy()

  it 'should provide a map of beds to bed counts', ->
    expect(scope.beds instanceof Object).toBeTruthy()

  it 'should provide a map of full baths to full bath counts', ->
    expect(scope.fbaths instanceof Object).toBeTruthy()

  it 'should provide an array of prices', ->
    expect(scope.prices instanceof Array).toBeTruthy()

  it 'should provide a map configuration for Google maps', ->
    expect(scope.mapOpts instanceof Object).toBeTruthy()

  it 'should provide a list of activity feeds', ->
    expect(scope.feeds instanceof Array).toBeTruthy()