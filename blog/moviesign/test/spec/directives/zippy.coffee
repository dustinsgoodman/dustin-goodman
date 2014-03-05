'use strict'

describe 'Directive: zippy', () ->
  elem = scope = null
  
  beforeEach ->
    # load the directive's module
    module 'dashboardApp'

    inject ($rootScope, $compile) ->
      scope = $rootScope
      elem = angular.element '<div data-zippy data-summary="Title">Content</div>'
      $compile(elem)(scope)
      scope.$digest()

  it 'should contain two divs', ->
    children = elem.children()
    expect(children.length).toBe 2
    expect(angular.element(children[0]).prop 'tagName').toBe 'DIV'
    expect(angular.element(children[1]).prop 'tagName').toBe 'DIV'

  it 'should have a h4 title with summary\'s content', ->
    isoScope = elem.isolateScope()
    title = elem.find('h4')
    expect(title.length).toBe 1
    expect(title.text()).toBe isoScope.summary

  it 'should have a div that contains the transcluded content', ->
    body = elem.find('div.panel-body')
    expect(body.length).toBe 1
    expect(body.html()).toBe '<span class="ng-scope">Content</span>'

  it 'should hide its content by default', ->
    body = elem.find('div.panel-collapse')
    expect(body.length).toBe 1
    expect(body.hasClass 'in').toBeFalsy

  it 'should show its content when clicked', ->
    elem.find('h4').click()
    body = elem.find('div.panel-collapse')
    expect(body.hasClass 'in').toBeTruthy

  it 'should hide its content when clicked twice', ->
    elem.find('h4').click().click()
    body = elem.find('div.panel-collapse')
    expect(body.hasClass 'in').toBeFalsy