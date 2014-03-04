'use strict'

describe 'Service: routes', () ->
  routes = null

  
  beforeEach ->
    # load the service's module
    module 'dashboardApp'

    inject (_routes_) ->
      routes = _routes_

  it 'should exist', ->
    expect(!!routes).toBe yes

  describe 'the service api', ->

    it 'should provide a session resource', ->
      expect(typeof routes.session).toBe 'function'

    describe 'the session api', ->
      session = routes.session

      it 'should provide a method login', ->
        expect(typeof session.login).toBe 'function'

      it 'should provide a method logout', ->
        expect(typeof session.logout).toBe 'function'

    it 'should provide a feeds resource', ->
      expect(typeof routes.feeds).toBe 'function'