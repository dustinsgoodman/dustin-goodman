'use strict'

describe 'Controller: SettingsCtrl', () ->
  scope = SettingsCtrl = null
  
  beforeEach ->
    # load the controller's module
    module 'dashboardApp'

    # Initialize the controller and a mock scope
    inject ($controller, $rootScope) ->
      scope = $rootScope.$new()
      SettingsCtrl = $controller 'SettingsCtrl',
        $scope: scope