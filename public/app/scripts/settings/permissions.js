(function(exports) {
  'use strict';

  var config;

  /*
    List all the roles you wish to use in the app
    You have a max of 31 before the bit shift pushes 
    the accompanying integer out of the memory footprint 
    for an integer       
    
    Build out all the access levels you want referencing 
    the roles listed above. You can use the "*" symbol 
    to represent access to all roles.

    Method to build a distinct bit mask for each role
    It starts off with "1" and shifts the bit to the 
    left for each element in the roles array parameter
  */
  function buildRoles(roles) {
    var bitmask = 1,
        userRoles = {};
    _.each(roles, function(role) {
      this[role] = {bitmask: bitmask, title: role};
      bitmask <<= 1;
    }, userRoles);

    return userRoles;
  }

  /*
    This method builds access level bit masks based 
    on the accessLevelDeclaration parameter which must
    contain an array for each access level containing 
    the allowed user roles.
  */
  function buildAccessLevels(accessLevelDeclarations, userRoles) {
    var accessLevels, level, resultBitmask, role;

    accessLevels = {};
    for (level in accessLevelDeclarations) {
      if (_.isString(accessLevelDeclarations[level])) {
        if (accessLevelDeclarations[level] === '*') {
          resultBitmask = '';

          for (role in userRoles) { resultBitmask += '1'; }

          accessLevels[level] = {
            bitmask: parseInt(resultBitmask, 2)
          };
        } else {
          console.log('Access Control Error: Could not parse "' +
            accessLevelDeclarations[level] +
            '" as access definition for level "' +
            level + '"');
        }
      } else {
        resultBitmask = 0;

        for (role in accessLevelDeclarations[level]) {
          if (userRoles.hasOwnProperty(accessLevelDeclarations[level][role])) {
            resultBitmask |= userRoles[accessLevelDeclarations[level][role]].bitmask;
          } else {
            console.log('Access Control Error: Could not find role "' +
              accessLevelDeclarations[level][role] +
              '" in registered roles while building access for "' +
              level + '"');
          }
        }
        accessLevels[level] = {
          bitmask: resultBitmask
        };
      }
    }

    return accessLevels;
  }

  config = {
    roles: ['public', 'user', 'admin'],
    accessLevels: {
      'public' : '*',
      'anon': ['public'],
      'user' : ['user', 'admin'],
      'admin': ['admin']
    }
  };

  exports.userRoles = buildRoles(config.roles);
  exports.accessLevels = buildAccessLevels(config.accessLevels, exports.userRoles);
})(typeof exports === 'undefined' ? this.permissions = {} : exports);