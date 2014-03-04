'use strict'

describe 'Controller: MainCtrl', () ->
  scope = Auth = null

  # load the controller's module
  beforeEach ->
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, _Auth_) ->
      scope = $rootScope.$new()
      MainCtrl = $controller 'MainCtrl',
        $scope: scope
      Auth = _Auth_

  it 'should provide a boolean called isLoggedIn', ->
    expect(typeof scope.isLoggedIn).toBe 'boolean'

  it 'should provide an array of links', ->
    expect(scope.links instanceof Array).toBeTruthy()
    _.each scope.links, (link) ->
      expect(link instanceof Object).toBeTruthy()
      expect(link.hasOwnProperty 'icon').toBeTruthy()
      expect(link.hasOwnProperty 'anchor').toBeTruthy()
      expect(link.hasOwnProperty 'text').toBeTruthy()
      expect(link.hasOwnProperty 'access').toBeTruthy()