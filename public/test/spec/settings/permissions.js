'use strict';

describe('Setting: permissions', function() {

  it('should provide userRoles and accessLevels', function() {
    expect(_.isObject(permissions.userRoles)).toBeTruthy();
    expect(_.isObject(permissions.accessLevels)).toBeTruthy();
  });

  it('should provide strictly defined userRoles', function() {
    var ur = permissions.userRoles;

    expect(ur.hasOwnProperty('public')).toBeTruthy();
    expect(ur.public).toEqual({bitmask: 1, title: 'public'});

    expect(ur.hasOwnProperty('user')).toBeTruthy();
    expect(ur.user).toEqual({bitmask: 2, title: 'user'});

    expect(ur.hasOwnProperty('admin')).toBeTruthy();
    expect(ur.admin).toEqual({bitmask: 4, title: 'admin'});
  });

  it('should provide stritly defined accessLevels', function() {
    var al = permissions.accessLevels;

    expect(al.hasOwnProperty('public')).toBeTruthy();
    expect(al.public).toEqual({bitmask: 7});

    expect(al.hasOwnProperty('anon')).toBeTruthy();
    expect(al.anon).toEqual({bitmask: 1});

    expect(al.hasOwnProperty('user')).toBeTruthy();
    expect(al.user).toEqual({bitmask: 6});

    expect(al.hasOwnProperty('admin')).toBeTruthy();
    expect(al.admin).toEqual({bitmask: 4});
  });

});