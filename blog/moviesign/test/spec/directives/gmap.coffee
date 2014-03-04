'use strict'

describe 'Directive: gmap', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<gmap></gmap>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the gmap directive'
