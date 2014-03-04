'use strict'

describe 'Controller: ProspectsCtrl', () ->
  scope = ProspectsCtrl = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope) ->
      scope = $rootScope.$new()
      ProspectsCtrl = $controller 'ProspectsCtrl',
        $scope: scope
      

  it 'should provide an object of column options for ngGrid', ->
    expect(scope.colOpts instanceof Object).toBeTruthy()

  it 'should provide a list of prospects', ->
    expect(scope.prospects instanceof Array).toBeTruthy()

  it 'should provide a list of columns for ngGrid', ->
    expect(scope.columns instanceof Array).toBeTruthy()

  it 'should provide a configuration object for ngGrid', ->
    expect(scope.gridOpts instanceof Object).toBeTruthy()

  it 'should provide a fuction that gets the current column number', ->
    expect(typeof getNumber).toBe 'function'