'use strict'

describe 'Directive: accessLevel', () ->
  elem = scope = compile = Auth = null

  beforeEach ->
    # load the directive's module
    module 'dashboardApp'

    inject ($rootScope, $compile, _Auth_) ->
      scope = $rootScope
      compile = $compile
      Auth = _Auth_