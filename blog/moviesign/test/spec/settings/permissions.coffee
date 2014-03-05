'use strict'

describe 'Settings: permissions', () ->

  it 'should provide userRoles and accessLevels', ->
    expect(permissions.userRoles instanceof Object).toBe true
    expect(permissions.accessLevels instanceof Object).toBe true

  it 'should provide strictly defined userRoles', ->
    ur = permissions.userRoles

    expect(ur.hasOwnProperty 'public').toBe true
    expect(ur.public).toEqual {bitMask: 1, title: 'public'}

    expect(ur.hasOwnProperty 'agent').toBe true
    expect(ur.agent).toEqual {bitMask: 2, title: 'agent'}

    expect(ur.hasOwnProperty 'coordinator').toBe true
    expect(ur.coordinator).toEqual {bitMask: 4, title: 'coordinator'}

    expect(ur.hasOwnProperty 'broker').toBe true
    expect(ur.broker).toEqual {bitMask: 8, title: 'broker'}

    expect(ur.hasOwnProperty 'admin').toBe true
    expect(ur.admin).toEqual {bitMask: 16, title: 'admin'}

  it 'should provide strictly defined accessLevels', ->
    al = permissions.accessLevels

    expect(al.hasOwnProperty 'public').toBe true
    expect(al.public).toEqual {bitMask: 31, title: '*'}

    expect(al.hasOwnProperty 'anon').toBe true
    expect(al.anon).toEqual {bitMask: 1, title: 'public'}

    expect(al.hasOwnProperty 'agent').toBe true
    expect(al.agent).toEqual {bitMask: 30, title: 'admin'}

    expect(al.hasOwnProperty 'coordinator').toBe true
    expect(al.coordinator).toEqual {bitMask: 28, title: 'admin'}

    expect(al.hasOwnProperty 'broker').toBe true
    expect(al.broker).toEqual {bitMask: 24, title: 'admin'}

    expect(al.hasOwnProperty 'admin').toBe true
    expect(al.admin).toEqual {bitMask: 16, title: 'admin'}