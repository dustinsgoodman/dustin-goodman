'use strict'

describe 'Filter: checkmark', () ->

  # load the filter's module
  beforeEach module 'dashboardApp'

  # initialize a new instance of the filter before each test
  checkmark = {}
  beforeEach inject ($filter) ->
    checkmark = $filter 'checkmark'

  it 'should return the input prefixed with "checkmark filter:"', () ->
    text = 'angularjs'
    expect(checkmark text).toBe ('checkmark filter: ' + text)
