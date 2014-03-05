'use strict';

describe('Controller: BlogNewCtrl', function () {

  // load the controller's module
  beforeEach(module('dustinGoodmanApp'));

  var BlogNewCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    BlogNewCtrl = $controller('BlogNewCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
