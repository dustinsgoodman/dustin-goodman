'use strict'

describe 'Directive: feedTypes/searchedProperties', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/searched-properties></feed-types/searched-properties>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/searchedProperties directive'
