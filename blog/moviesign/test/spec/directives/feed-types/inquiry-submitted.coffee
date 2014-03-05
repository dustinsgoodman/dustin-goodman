'use strict'

describe 'Directive: feedTypes/inquirySubmitted', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/inquiry-submitted></feed-types/inquiry-submitted>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/inquirySubmitted directive'
