'use strict';

angular.module('dustinGoodmanApp').filter('errors', function () {
  function capitalize (str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
  }

  function prettifyLabel (str) {
    return capitalize(str.split('_').join(' '));
  }

  return function (input) {
    var errorList = [];
    _.each(input, function (errors,label) {
      _.each(errors, function (error) {
        errorList.push(prettifyLabel(label) + ' ' + error);
      });
    });
    return errorList;
  };
});