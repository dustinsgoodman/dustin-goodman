'use strict';

angular.module('dustinGoodmanApp').factory('Auth', [
  'User',
  'permissions',
  'defaultUser',
  '$rootScope',
  '$location',
  function (User, permissions, defaultUser, $rootScope, $location) {
  // Service logic
  var accessLevels = permissions.accessLevels,
      userRoles = permissions.userRoles,
      currentUser = angular.fromJson(localStorage.user) || defaultUser;

  function changeUser(user) {
    if (_.isString(user.role)) {
      user.role = userRoles[user.role];
    }
    _.extend(currentUser, user);
    if (user !== defaultUser) {
      localStorage.setItem('user', angular.toJson(user));
    } else {
      localStorage.setItem('user', null);
    }
  }

  // Public API here
  return {
    authorize: function (accessLevel, role) {
      if (_.isUndefined(role)) { role = currentUser.role; }
      return accessLevel.bitmask & role.bitmask;
    },
    isLoggedIn: function (user) {
      if (_.isUndefined(user)) { user = currentUser; }
      return user.role.bitmask > 1;
    },
    register: function (user) {
      var successCallback = function (resp) {
        changeUser(resp.data);
        $location.path('/');
      };
      var errorCallback = function (resp) {
        $rootScope.errors = resp.data.errors;
      };
      User.register(user, successCallback, errorCallback);
    },
    login: function(user) {
      var successCallback = function (resp) {
        changeUser(resp.data);
        $location.path('/');
      };
      var errorCallback = function (resp) {
        $rootScope.errors = resp.data.errors;
      };
      User.login(user, successCallback, errorCallback);
    },
    logout: function() {
      User.logout();
      changeUser(defaultUser);
    },
    accessLevels: accessLevels,
    userRoles: userRoles,
    user: currentUser
  };
}]);