'use strict'

describe 'Controller: LoginCtrl', () ->
  rootScope = scope = loc = win = Auth = null

  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, $location, $window, _Auth_) ->
      rootScope = $rootScope
      loc = $location
      win = $window
      Auth = _Auth_

      scope = $rootScope.$new()
      LoginCtrl = $controller 'LoginCtrl',
        $scope: scope

  it 'should provide a boolean called rememberme and init to false', ->
    expect(typeof scope.rememberme).toBe 'boolean'
    expect(scope.rememberme).toBe false

  it 'should define rootScope error to be null', ->
    expect(rootScope.error).toBe null

  it 'should provide a login method', ->
    expect(typeof scope.login).toBe 'function'