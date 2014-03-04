'use strict';

angular.module('dustinGoodmanApp').factory('Auth', [function() {
  // Service logic
  var accessLevels = permissions.accessLevels,
      userRoles = permissions.userRoles,
      defaultUser = {email: '', firstName: '', lastName: '', role: userRoles['public']},
      currentUser = angular.fromJson(localStorage.user) || defaultUser;

  // function changeUser(user) {
  //   _.extend(currentUser, user);
  // }

  // Public API here
  return {
    authorize: function(accessLevel, role) {
      if (_.isUndefined(role)) { role = currentUser.role; }
      console.log(accessLevel.bitmask, role.bitmask);
      return accessLevel.bitmask & role.bitmask;
    },
    isLoggedIn: function(user) {
      if (_.isUndefined(user)) { user = currentUser; }
      return user.role.title === userRoles.user.title ||
        user.role.title === userRoles.admin.title;
    },
    // register: function(user, success, error) {

    // },
    // login: function(user, success, error) {

    // },
    // logout: function(success, error) {

    // },
    accessLevels: accessLevels,
    userRoles: userRoles,
    user: currentUser
  };
}]);