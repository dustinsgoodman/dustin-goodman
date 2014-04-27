'use strict';

angular.module('dustinGoodmanApp').constant('permissions', {
  userRoles: {
    public: {bitmask: 1, title: 'public'},
    user: {bitmask: 2, title: 'user'},
    admin: {bitmask: 4, title: 'admin'}
  },
  accessLevels: {
    anon: {bitmask: 1},
    admin: {bitmask: 4},
    user: {bitmask: 6},
    public: {bitmask: 7}
  }
});