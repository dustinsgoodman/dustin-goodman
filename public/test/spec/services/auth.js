'use strict';

describe('Service: Auth', function () {

  var Auth, $rootScope, $httpBackend;

  beforeEach(function () {
    module('dustinGoodmanApp');

    // Provide any mocks needed
    // module(function ($provide) {
    //  $provide.value('Name', new MockName());
    // });

    // Inject in angular constructs otherwise,
    //  you would need to inject these into each test
    inject(function (_Auth_, _$rootScope_, _$httpBackend_) {
      Auth = _Auth_;
      $rootScope = _$rootScope_;
      $httpBackend = _$httpBackend_;

      // $httpBackend.expectGET('login').respond();
      // $httpBackend.flush();
    });
  });

  afterEach(function () {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });

  it('should exist', function () {
    expect(!!Auth).toBeTruthy();
  });


  describe('instantiate', function () {
    it('should have a isLoggedIn function', function() {
      expect(_.isUndefined(Auth.isLoggedIn)).toBeFalsy();
      expect(_.isFunction(Auth.isLoggedIn)).toBeTruthy();
    });

    it('should have an authorize function', function() {
      expect(_.isUndefined(Auth.authorize)).toBeFalsy();
      expect(_.isFunction(Auth.authorize)).toBeTruthy();
    });

    it('should have a login function', function() {
      expect(_.isUndefined(Auth.login)).toBeFalsy();
      expect(_.isFunction(Auth.login)).toBeTruthy();
    });

    it('should have a logout function', function() {
      expect(_.isUndefined(Auth.logout)).toBeFalsy();
      expect(_.isFunction(Auth.logout)).toBeTruthy();
    });

    it('should have a register function', function() {
      expect(_.isUndefined(Auth.register)).toBeFalsy();
      expect(_.isFunction(Auth.register)).toBeTruthy();
    });

    it('should have the user object', function() {
      expect(_.isUndefined(Auth.user)).toBeFalsy();
      expect(_.isObject(Auth.user)).toBeTruthy();
    });

    it('should have the userRoles object', function() {
      expect(_.isUndefined(Auth.userRoles)).toBeFalsy();
      expect(_.isObject(Auth.userRoles)).toBeTruthy();
    });

    it('should have the accessLevels object', function() {
      expect(_.isUndefined(Auth.accessLevels)).toBeFalsy();
      expect(_.isObject(Auth.accessLevels)).toBeTruthy();
    });

    it('should set the user object with no name and public role', function() {
      var defaultUser = {
        email: '',
        firstName: '',
        lastName: '',
        role: Auth.userRoles['public']
      };

      expect(_.isEqual(Auth.user, defaultUser)).toBeTruthy();
    });
  });
  
  describe('authorize', function() {
    it('should return 0 when role not recognized', function() {
      expect(Auth.authorize('foo')).toBe(0);
    });

    it('should return 1 when role is recognized', function() {
      var accessLevels = { bitmask: 1 },
          role = { bitmask: 1 };
      expect(Auth.authorize(accessLevels, role)).toBe(1);
    });

    it('should return 0 when role is omitted and not equal', function() {
      var accessLevels = { bitmask: 0 };
      expect(Auth.user.role.bitmask).toBe(1);
      expect(Auth.authorize(accessLevels)).toBe(0);
    });

    it('should return 1 when role is omitted but equal', function() {
      var accessLevels = { bitmask: 1 };
      expect(Auth.user.role.bitmask).toBe(1);
      expect(Auth.authorize(accessLevels)).toBe(1);
    });
  });

  describe('isLoggedIn', function() {
    it('should use the currentUser when user omitted', function() {
      expect(Auth.isLoggedIn()).toBeFalsy();
    });

    it('should return false when user has role public', function() {
      var user = { role: { title: 'public' } };
      expect(Auth.isLoggedIn(user)).toBeFalsy();
    });

    it('should return true when user has role user', function() {
      var user = { role: { title: 'user' } };
      expect(Auth.isLoggedIn(user)).toBeTruthy();
    });

    it('should return true when user has role admin', function() {
      var user = { role: { title: 'admin' } };
      expect(Auth.isLoggedIn(user)).toBeTruthy();
    });
  });

  /*
  describe('register', function() {
    it('should make a request and invoke callback', function() {
      var invoked = false,
          success = function() { invoked = true; },
          error = function() {};

      $httpBackend.flush();
      $httpBackend.expectPOST('/register').respond();
      Auth.register({}, success, error);
      $httpBackend.flush();

      expect(invoked).toBeTruthy();
    });

    it('should append the user', function() {
      var success = function() {},
          error = function() {},
          testUser = { username : '', role : { bitMask : 1, title : 'public' }, user : 'foo' };

      $httpBackend.flush();
      $httpBackend.expectPOST('/register').respond({ 'user': 'foo' });
      Auth.register({}, success, error);
      $httpBackend.flush();

      expect(_.isEqual(Auth.user, testUser)).toBeTruthy();
    });
  });

  describe('login', function() {
    it('should make a request and invoke callback', function() {
      var invoked = false,
          success = function() { invoked = true; };
          error = function() {};

      $httpBackend.flush();
      $httpBackend.expectPOST('/login').respond();
      Auth.login({}, success, error);
      $httpBackend.flush();

      expect(invoked).toBeTruthy();
    });

    it('should append the user', function() {
      var success = function() {},
          error = function() {},
          testUser = { username : '', role : { bitMask : 1, title : 'public' }, user : 'bar' };

      $httpBackend.flush();
      $httpBackend.expectPOST('/login').respond({ 'user': 'bar' });
      Auth.login({}, success, error);
      $httpBackend.flush();

      expect(_.isEqual(Auth.user, testUser)).toBeTruthy();
    });
  });

  describe('logout', function() {
    it('should make a request and invoke callback', function() {
      var invoked = false,
          success = function() { invoked = true; },
          error = function() {};

      $httpBackend.flush();
      $httpBackend.expectPOST('/logout').respond();
      Auth.logout(success, error);
      $httpBackend.flush();

      expect(invoked).toBeTruthy();
    });
  });
  */
});