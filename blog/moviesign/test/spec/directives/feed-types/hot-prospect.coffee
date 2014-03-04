'use strict'

describe 'Directive: feedTypes/hotProspect', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/hot-prospect></feed-types/hot-prospect>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/hotProspect directive'
