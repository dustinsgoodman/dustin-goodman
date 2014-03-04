'use strict'

describe 'Directive: userLayout', () ->
  elem = scope = null

  beforeEach ->
    # load the app and template(s)
    module 'dashboardApp', 'views/user-layout.html'

    #inject directive into each test
    inject ($rootScope, $compile, $templateCache) ->
      scope = $rootScope
      elem = angular.element '<div class="login-layout"><div data-user-layout></div></div>'
      elem = $compile(elem)(scope)
      $templateCache.put('views/main.html', 'Content')
      $templateCache.put('views/login.html', 'Content')
      scope.$digest()

  it 'should remove class login-layout from body', ->
    expect($('body').hasClass 'login-layout').toBeFalsy

  it 'should have 2 main sections', ->
    expect(elem.length).toBe 1
    expect(elem.find('header').attr('id')).toBe 'navbar'
    expect(elem.find('section').attr('id')).toBe 'main-container'

  it 'should contain a ngView attribute', ->
    page = elem.find('.page-content div:first-child div:first-child').first()
    expect(page.length).toBe 1
    expect(page.attr('data-ng-view')).toBe ''
    expect(page.text()).toBe 'Content'