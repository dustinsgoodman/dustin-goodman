'use strict';

angular.module('dustinGoodmanApp').factory('User', [
  'Restangular',
  function (Restangular) {
    var userPath = Restangular.all('users');

    var signup = function () {
      return userPath.one('sign_up').get().$object;
    };

    var register = function (data, success, error) {
      return userPath.post({user: data}).then(success, error);
    };

    var login = function (data, success, error) {
      return userPath.all('sign_in').post({user: data}).$object();
    };

    var logout = function (data) {
      userPath.all('sign_out').remove();
      return;
    };

    // Public API here
    return {
      signup: signup,
      register: register,
      login: login,
      logout: logout
    };
  }
]);