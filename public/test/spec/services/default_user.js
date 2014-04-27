'use strict';

describe('Service: defaultUser', function () {

  // load the service's module
  beforeEach(module('dustinGoodmanApp'));

  // instantiate service
  var defaultUser;
  beforeEach(inject(function (_defaultUser_) {
    defaultUser = _defaultUser_;
  }));

  it('should do something', function () {
    expect(!!defaultUser).toBe(true);
  });

});
