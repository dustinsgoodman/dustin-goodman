'use strict';

describe('Filter: errors', function () {

  // load the filter's module
  beforeEach(module('dustinGoodmanApp'));

  // initialize a new instance of the filter before each test
  var errors;
  beforeEach(inject(function ($filter) {
    errors = $filter('errors');
  }));

  it('should return the input prefixed with "errors filter:"', function () {
    var text = 'angularjs';
    expect(errors(text)).toBe('errors filter: ' + text);
  });

});
