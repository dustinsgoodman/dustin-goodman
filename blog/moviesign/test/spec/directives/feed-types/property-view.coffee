'use strict'

describe 'Directive: feedTypes/propertyView', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/property-view></feed-types/property-view>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/propertyView directive'
