'use strict'

describe 'Directive: widget', () ->
  elem = scope = null

  
  beforeEach ->
    # load the directive's module
    module 'dashboardApp'

    inject ($rootScope, $compile) ->
      scope = $rootScope
      elem = angular.element '<div widget title="Title" close-callback="true">Content</div>'
      $compile(elem)(scope)
      scope.$digest()

  it 'should contain two divs', ->
    children = elem.children()
    expect(children.length).toBe 2
    expect(angular.element(children[0]).prop 'tagName').toBe 'DIV'
    expect(angular.element(children[0]).hasClass 'widget-header').toBeTruthy
    expect(angular.element(children[1]).prop 'tagName').toBe 'DIV'
    expect(angular.element(children[1]).hasClass 'widget-body').toBeTruthy

  it 'should have a h5 title with title', ->
    isoScope = elem.isolateScope()
    title = elem.find('h5')
    expect(title.length).toBe 1
    expect(title.text()).toBe isoScope.title

  it 'should have a div that contains the transcluded content', ->
    body = elem.find('div.widget-main')
    expect(body.length).toBe 1
    expect(body.html()).toBe '<span class="ng-scope">Content</span>'

  it 'should have a close action', ->
    isoScope = elem.isolateScope()
    expect(typeof isoScope.closeCallback).toBe 'function'