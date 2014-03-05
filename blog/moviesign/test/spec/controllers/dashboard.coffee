'use strict'

describe 'Controller: DashboardCtrl', () ->
  scope = DashboardCtrl = Routes = DataParser = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'


    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, _Routes_, _Auth_) ->
      scope = $rootScope.$new()
      DashboardCtrl = $controller 'DashboardCtrl',
        $scope: scope
      Routes = _Routes_
      Auth = _Auth_

  it 'should provide a list of feeds', ->
    expect(scope.feeds instanceof Array).toBeTruthy()

  it 'should provide a method for removing feeds', ->
    expect(typeof scope.removeFeed).toBeTruthy()