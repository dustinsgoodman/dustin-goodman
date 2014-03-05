'use strict'

describe 'Directive: feedTypes/showingRequest', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/showing-request></feed-types/showing-request>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/showingRequest directive'
