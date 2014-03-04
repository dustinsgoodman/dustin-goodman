'use strict'

describe 'Controller: RegisterCtrl', () ->
  scope = RegisterCtrl = Auth = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, _Auth_) ->
      scope = $rootScope.$new()
      RegisterCtrl = $controller 'RegisterCtrl',
        $scope: scope
      Auth = _Auth_

  it 'should provide access roles', ->
    expect(scope.role instanceof Object).toBeTruthy()
    expect(scope.userRoles instanceof Object).toBeTruthy()

  it 'should provide a register function', ->
    expect(typeof scope.register).toBe 'function'