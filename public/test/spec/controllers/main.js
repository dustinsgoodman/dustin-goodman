'use strict';

describe('Controller: MainCtrl', function () {

  var MainCtrl, scope;

  beforeEach(function() {
    // load the controller's module
    module('dustinGoodmanApp');
   
    // Provide any mocks needed
    // module(function ($provide) {
    //   $provide.value('mySvc', new MockMySvc());
    // });

    // Inject in angular constructs otherwise,
    //  you would need to inject these into each test
    inject(function ($controller) {
      scope = {};
      MainCtrl = $controller('MainCtrl', {
        $scope: scope
      });
    });

  });

  it('should provide a boolean isNavCollapsed property', function () {
    expect(typeof scope.isNavCollapsed).toBe('boolean');
  });
});
