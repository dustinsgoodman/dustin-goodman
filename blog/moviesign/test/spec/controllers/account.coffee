'use strict'

describe 'Controller: AccountCtrl', () ->
  scope = AccountCtrl = Auth = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope, _Auth_) ->
      scope = $rootScope.$new()
      AccountCtrl = $controller 'AccountCtrl',
        $scope: scope
      Auth = _Auth_

  it 'should provide a user', ->
    expect(scope.user instanceof Object).toBeTruthy()