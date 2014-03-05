'use strict'

describe 'Directive: feedTypes/areaReport', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/area-report></feed-types/area-report>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/areaReport directive'
