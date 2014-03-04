'use strict'

describe 'Filter: nullDateFilter', () ->

  # load the filter's module
  beforeEach module 'dashboardApp'

  # initialize a new instance of the filter before each test
  nullDateFilter = {}
  beforeEach inject ($filter) ->
    nullDateFilter = $filter 'nullDateFilter'

  it 'should return the input prefixed with "nullDateFilter filter:"', () ->
    text = 'angularjs'
    expect(nullDateFilter text).toBe ('nullDateFilter filter: ' + text)
