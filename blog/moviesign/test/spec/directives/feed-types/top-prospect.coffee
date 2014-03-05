'use strict'

describe 'Directive: feedTypes/topProspect', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/top-prospect></feed-types/top-prospect>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/topProspect directive'
