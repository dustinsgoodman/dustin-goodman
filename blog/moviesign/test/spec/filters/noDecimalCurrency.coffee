'use strict'

describe 'Filter: noDecimalCurrency', () ->

  # load the filter's module
  beforeEach module 'dashboardApp'

  # initialize a new instance of the filter before each test
  noDecimalCurrency = {}
  beforeEach inject ($filter) ->
    noDecimalCurrency = $filter 'noDecimalCurrency'

  it 'should return the input prefixed with "noDecimalCurrency filter:"', () ->
    text = 'angularjs'
    expect(noDecimalCurrency text).toBe ('noDecimalCurrency filter: ' + text)
