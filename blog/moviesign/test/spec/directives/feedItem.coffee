'use strict'

describe 'Directive: feedItem', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-item></feed-item>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedItem directive'
