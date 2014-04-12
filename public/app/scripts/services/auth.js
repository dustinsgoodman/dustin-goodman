'use strict';

angular.module('dustinGoodmanApp').factory('Auth', ['Restangular', function (Restangular) {
  // Service logic
  var accessLevels = permissions.accessLevels,
      userRoles = permissions.userRoles,
      defaultUser = {
        'email': '',
        'first_name': '',
        'last_name': '',
        'role': userRoles['public']
      },
      currentUser = angular.fromJson(localStorage.user) || defaultUser;

  function changeUser(user) {
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
      return accessLevel.bitmask & role;
    },
    isLoggedIn: function (user) {
      if (_.isUndefined(user)) { user = currentUser; }
      return user.role > 1;
    },
    register: function (user, success, error) {
      Restangular.all('users').post(user).then(
        function (res) {
          changeUser(res.data);
          success(res);
        },
        function (res) {
          error(res);
        }
      );
    },
    // login: function(user, success, error) {

    // },
    // logout: function(success, error) {

    // },
    accessLevels: accessLevels,
    userRoles: userRoles,
    user: currentUser
  };
}]);