'use strict'

describe 'Controller: ForgotCtrl', () ->
  scope = ForgotCtrl = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope) ->
      scope = $rootScope.$new()
      ForgotCtrl = $controller 'ForgotCtrl',
        $scope: scope