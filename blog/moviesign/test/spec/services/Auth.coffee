'use strict'
describe 'Service: Auth', ->
  httpBackend = Auth = Session = null
  validUser =
    email: 'test@clickscape.com'
    sessionId: 1
    fname: 'Test'
    lname: 'Clickscape'
    role: {'bitMask': 2, title: 'agent'}
  invalidUser =
    email: ''
    sessionId: 0
    fname: ''
    lname: ''
    role: {'bitMask': 1, title: 'public'}

  beforeEach ->
    # Load the service's module
    module 'dashboardApp'

    # Provide any mocks needed
    module ($provide) ->
      null

    # Inject in angular constructs otherwise,
    #  you would need to inject these into each test
    inject ($httpBackend, _Auth_, _Session_) ->
      Auth = _Auth_
      Session = _Session_
      
      # setup up mock http service responses
      httpBackend = $httpBackend

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  it 'should exist', ->
    expect(!!Auth).toBe yes

  describe 'the service api', ->
    # Add specs
    it 'should provide a current user', ->
      user = Auth.user
      expect(user instanceof Object).toBe true

      expect(user.hasOwnProperty 'email').toBe true
      expect(typeof user.email).toBe 'string'

      expect(user.hasOwnProperty 'sessionId').toBe true
      expect(typeof user.sessionId).toBe 'number'

      expect(user.hasOwnProperty 'fname').toBe true
      expect(typeof user.fname).toBe 'string'

      expect(user.hasOwnProperty 'lname').toBe true
      expect(typeof user.lname).toBe 'string'

      expect(user.hasOwnProperty 'role').toBe true
      expect(user.role instanceof Object).toBe true
      expect(user.role.hasOwnProperty 'bitMask').toBe true
      expect(user.role.hasOwnProperty 'title').toBe true
      
    it 'should provide all user roles', ->
      userRoles = Auth.userRoles
      expect(userRoles instanceof Object).toBe true

      expect(userRoles.hasOwnProperty 'public').toBe true
      expect(userRoles.public.hasOwnProperty 'bitMask').toBe true
      expect(userRoles.public.hasOwnProperty 'title').toBe true

      expect(userRoles.hasOwnProperty 'agent').toBe true
      expect(userRoles.agent.hasOwnProperty 'bitMask').toBe true
      expect(userRoles.agent.hasOwnProperty 'title').toBe true

      expect(userRoles.hasOwnProperty 'coordinator').toBe true
      expect(userRoles.coordinator.hasOwnProperty 'bitMask').toBe true
      expect(userRoles.coordinator.hasOwnProperty 'title').toBe true

      expect(userRoles.hasOwnProperty 'broker').toBe true
      expect(userRoles.broker.hasOwnProperty 'bitMask').toBe true
      expect(userRoles.broker.hasOwnProperty 'title').toBe true

      expect(userRoles.hasOwnProperty 'admin').toBe true
      expect(userRoles.admin.hasOwnProperty 'bitMask').toBe true
      expect(userRoles.admin.hasOwnProperty 'title').toBe true

    it 'should provide all access levels', ->
      accessLevels = Auth.accessLevels
      expect(accessLevels instanceof Object).toBe true

      expect(accessLevels.hasOwnProperty 'public').toBe true
      expect(accessLevels.public.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.public.hasOwnProperty 'title').toBe true

      expect(accessLevels.hasOwnProperty 'anon').toBe true
      expect(accessLevels.anon.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.anon.hasOwnProperty 'title').toBe true

      expect(accessLevels.hasOwnProperty 'agent').toBe true
      expect(accessLevels.agent.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.agent.hasOwnProperty 'title').toBe true

      expect(accessLevels.hasOwnProperty 'coordinator').toBe true
      expect(accessLevels.coordinator.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.coordinator.hasOwnProperty 'title').toBe true

      expect(accessLevels.hasOwnProperty 'broker').toBe true
      expect(accessLevels.broker.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.broker.hasOwnProperty 'title').toBe true

      expect(accessLevels.hasOwnProperty 'admin').toBe true
      expect(accessLevels.admin.hasOwnProperty 'bitMask').toBe true
      expect(accessLevels.admin.hasOwnProperty 'title').toBe true

    it 'should provide an authorize method that returns a bitmask', ->
      expect(typeof Auth.authorize).toBe 'function'
      expect(typeof Auth.authorize(Auth.accessLevels.public)).toBe 'number'
      expect(typeof Auth.authorize(Auth.accessLevels.public), Auth.user.role).toBe 'number'

    it 'should provide an isLoggedIn method that returns false when invalid user', ->
      expect(typeof Auth.isLoggedIn).toBe 'function'
      expect(typeof Auth.isLoggedIn(Auth.user)).toBe 'boolean'
      expect(Auth.isLoggedIn(Auth.user)).toBe false

    it 'should provide a login method', ->
      expect(typeof Auth.login).toBe 'function'

    it 'should provide an error callback on bad credentials', ->
      test = null
      httpBackend.when('POST', '/account/session').respond 401, {}
      Auth.login {}, ((res) -> test = true), ((err) -> test = false)
      httpBackend.flush()
      expect(test).toBe false
      expect(Auth.user).toEqual invalidUser

    it 'should change the user when login method is called', ->
      test = null
      httpBackend.when('POST', '/account/session').respond 201, validUser
      Auth.login {email: 'test@clickscape.com', password: '123', rememberme: false}, (-> test = true), (-> test = false)
      httpBackend.flush()
      expect(test).toBe true
      expect(Auth.user).not.toEqual validUser
      expect(Auth.isLoggedIn(Auth.user)).toBe true

    it 'should provide a logout method', ->
      httpBackend.when('DELETE', '/account/session').respond 200, {}
      Auth.logout (->), (->)
      httpBackend.flush()
      expect(Auth.user).toEqual invalidUser