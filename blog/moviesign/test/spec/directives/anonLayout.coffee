'use strict'

describe 'Directive: anonLayout', () ->
  elem = scope = null

  beforeEach ->
    # load the app and template(s)
    module 'dashboardApp', 'views/anon-layout.html'

    #inject directive into each test
    inject ($rootScope, $compile, $templateCache) ->
      scope = $rootScope
      elem = angular.element '<div><div data-anon-layout></div></div>'
      $compile(elem)(scope)
      $templateCache.put('views/main.html', 'Content')
      $templateCache.put('views/login.html', 'Content')
      scope.$digest()


  it 'should add class login-layout to body', ->
    expect($('body').hasClass 'login-layout').toBeTruthy

  it 'should have anon access permissions', ->
    section = elem.find('section')
    expect(section.length).toBe 1
    expect(section.attr('data-access-level')).toBe 'accessLevels.anon'

  it 'should render the Clickscape logo in h1 tags', ->
    logo = elem.find('h1')
    expect(logo.length).toBe 1
    expect(logo.html()).toBe '<img src="images/logo.png">'

  it 'should contain a ngView attribute', ->
    view = elem.find('div[data-ng-view=""]')
    expect(view.length).toBe 1
    expect(view.attr('data-ng-view')).toBe ''
    expect(view.text()).toBe 'Content'