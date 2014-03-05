'use strict';

angular.module('dashboardApp')
  .factory 'Auth', [
    '$cookieStore'
    '$location'
    'Routes'
    ($cookieStore, $location, Routes) ->
      # Service logic
      accessLevels = permissions.accessLevels
      userRoles = permissions.userRoles
      defaultUser =
        sessionKey: ''
        loginKey: ''
        userId: 0
        email: ''
        firstName: ''
        lastName: ''
        phone: ''
        role: userRoles.public
      currentUser = angular.fromJson(localStorage.user) or _.extend {}, defaultUser
      Routes.setSessionHeaders(currentUser)

      changeUser = (user) ->
        if user.role instanceof Array
          user.role = _.chain(user.role)
            .map((role) -> userRoles[role])
            .max((ur) -> ur.bitMask)
            .value()
        _.extend currentUser, user

      # Public API
      {
        authorize: (accessLevel, role) ->
          role = currentUser.role if role is undefined
          accessLevel.bitMask & role.bitMask
        isLoggedIn: (user) ->
          user = currentUser if user is undefined
          user.role.title in [
            userRoles.agent.title
            userRoles.coordinator.title
            userRoles.broker.title
            userRoles.admin.title
          ]
        # register: (user, success, error) ->
        #   $http.post('/register', user).success((res) ->
        #     changeUser(res)
        #     success()
        #   ).error(error)
        login: (user, success, error) ->
          Routes.account().all('session').all('login').post(user).then(
            ((res) -> 
              changeUser res.data
              Routes.setSessionHeaders(currentUser)
              localStorage.user = angular.toJson currentUser
              success user
            ),
            ((err) -> 
              error()
            )
          )            
        logout: ->
          Routes.account().one('session', currentUser.userId).remove().then ->
            changeUser defaultUser
            Routes.setSessionHeaders(currentUser)
            localStorage.user = null
            $location.path '/login'

        accessLevels: accessLevels
        userRoles: userRoles
        user: currentUser
      }
  ]
