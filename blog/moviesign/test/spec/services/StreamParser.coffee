'use strict'

describe 'Service: Streamparser', () ->

  # load the service's module
  beforeEach module 'dashboardApp'

  # instantiate service
  Streamparser = {}
  beforeEach inject (_Streamparser_) ->
    Streamparser = _Streamparser_

  it 'should do something', () ->
    expect(!!Streamparser).toBe true
