'use strict'

describe 'Directive: feedTypes/contactForm', () ->

  # load the directive's module
  beforeEach module 'dashboardApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<feed-types/contact-form></feed-types/contact-form>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the feedTypes/contactForm directive'
