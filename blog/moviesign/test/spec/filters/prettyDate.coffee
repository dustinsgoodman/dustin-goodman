'use strict'

describe 'Filter: prettyDate', () ->

  # load the filter's module
  beforeEach module 'dashboardApp'

  # initialize a new instance of the filter before each test
  prettyDate = {}
  beforeEach inject ($filter) ->
    prettyDate = $filter 'prettyDate'

  it 'should return the input prefixed with "prettyDate filter:"', () ->
    text = 'angularjs'
    expect(prettyDate text).toBe ('prettyDate filter: ' + text)
