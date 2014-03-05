'use strict'

app = angular.module 'dashboardApp', [
  'ngRoute'
  'ngResource'
  'ngCookies'
  'ngSanitize'
  'restangular'
  'ngGrid'
  'infinite-scroll',
  'ui.bootstrap'
]

app.config [
  '$routeProvider'
  '$locationProvider'
  '$httpProvider'
  'RestangularProvider'
  ($routeProvider, $locationProvider, $httpProvider, RestangularProvider) ->
    RestangularProvider.setBaseUrl('/api')
    RestangularProvider.setFullResponse(true)

    access = permissions.accessLevels
    $routeProvider
      .when('/',
        templateUrl: '/views/dashboard.html'
        controller: 'DashboardCtrl'
        access: access.agent
        resolve:
          dashboard: ['Routes', 'Auth', '$location', (Routes, Auth, $location) ->
            Routes.feeds(Auth.user.userId).getList().then((resp) -> resp)
          ]
      )
      .when('/login',
        templateUrl: '/views/login.html'
        controller: 'LoginCtrl'
        access: access.anon
      )
      # .when('/register',
      #   templateUrl: 'views/register.html'
      #   controller: 'RegisterCtrl'
      #   access: access.anon)
      .when('/forgot',
        templateUrl: '/views/forgot.html'
        controller: 'ForgotCtrl'
        access: access.anon
      )
      .when('/prospects',
        templateUrl: '/views/prospects.html'
        controller: 'ProspectsCtrl'
        access: access.agent
        resolve:
          prospects: ['Routes', '$location', (Routes, $location) ->
            Routes.prospects().getList().then((resp) ->
              _.map(resp.data, (prospect) ->
                _.each(prospect, ((v,k) ->
                  if not v?
                    if k in ['prospectFirstActivity', 'prospectLastActivity']
                      this[k] = 0
                    else
                      this[k] = ''
                ), prospect)
                prospect
              )
            )
          ]
      )
      .when('/prospect/:id',
        templateUrl: '/views/prospect.html'
        controller: 'ProspectCtrl'
        access: access.agent
        resolve:
          prospect: ['Routes', '$route', (Routes, $route) ->
            Routes.prospects($route.current.params.id).get().then((resp) -> resp.data)
          ]
          profile: ['Routes', '$route', (Routes, $route) ->
            Routes.prospects($route.current.params.id, 'profiles').getList().then(
              (resp) ->
                if not _.isEmpty(resp.data) and resp.data[0].profile.profile.property.mostViews.propertyInfo?
                  mlsId = resp.data[0].profile.profile.property.mostViews.propertyInfo.mlsId
                  mlsNum = resp.data[0].profile.profile.property.mostViews.propertyInfo.mlsNum
                  Routes.listings(mlsId, mlsNum).get().then((listing) ->
                    resp.data[0].profile.profile.property.mostViews.propertyInfo = listing.data
                  )
                resp.data[0]
            )
          ]
          notes: ['Routes', '$route', (Routes, $route) ->
            Routes.prospects($route.current.params.id, 'notes').getList().then(
              (resp) -> resp
            )
          ]
          agents: ['Routes', 'Auth', (Routes, Auth) ->
            if Auth.authorize(Auth.userRoles.admin)
              Routes.admin('agents').getList().then(
                (resp) -> resp.data
              )
            else
              null
          ]
          locations: ['Routes', '$route', (Routes, $route) ->
            Routes.prospects($route.current.params.id, 'property-views').getList().then((resp) ->
              _.chain(resp.data.propertyInfo)
                .filter((listing) -> listing? and listing.latitude? and listing.longitude?)
                .map((listing) -> [listing.latitude, listing.longitude])
                .value()
            )
          ]
      )
      .when('/listings/:mlsId/:mlsNum',
          templateUrl: '/views/listing.html'
          controller: 'ListingCtrl'
          access: access.agent
          resolve:
            listing: ['Routes', '$route', '$location', (Routes, $route, $location) ->
              Routes.listings($route.current.params.mlsId, $route.current.params.mlsNum).get().then(
                (resp) -> resp.data
              )
            ]
      )
      .when('/listings/notFound',
        templateUrl: '/views/listingNotFound.html'
        access: access.agent
      )
      .when '/admin/assignment',
        templateUrl: '/views/assignment.html'
        controller: 'AssignmentCtrl'
        access: access.admin
        resolve:
          prospects: ['Routes', '$location', (Routes, $location) ->
            Routes.admin('prospects').all('unassigned').getList({limit: 100, start: 0}).then(
              (resp) ->
                _.map(resp.data, (prospect) ->
                  _.each(prospect, ((v,k) ->
                    this[k] = '' if not v?
                  ), prospect)
                  prospect
                )
            )
          ]
          agents: ['Routes', (Routes) ->
            Routes.admin('agents').getList().then(
              (resp) -> resp.data
            )
          ]
      .when('/account',
        templateUrl: '/views/account.html'
        controller: 'AccountCtrl'
        access: access.agent
      )
      .when('/settings',
        templateUrl: '/views/settings.html'
        controller: 'SettingsCtrl'
        access: access.agent
      )
      .when('/404',
        templateUrl: '/views/404.html'
        access: access.public
      )
      .when('/500',
        templateUrl: '/views/500.html'
        access: access.public
      )
      .otherwise(
        redirectTo: '/404'
      )

    $locationProvider.html5Mode(true)

    $httpProvider.interceptors.push([
      '$location'
      '$q'
      ($location, $q) ->
        response: (response) ->
          if response.status is 204
            response.data = []
          return response
        responseError: (response) ->
          switch response.status
            when 401
              localStorage.user = null
              $location.path '/login'
            when 403
              $location.path '/'
            when 404
              if response.config.url.match(/\/api\/dashboard\/\d+\/activity/g)
                break
              else if response.config.url.match(/\/api\/mls\/\d+\/mls-num\/\d+/g)
                $location.path '/listings/notFound'
              $location.path '/404'
            when 500
              $location.path '/500'
            else
              console.log "unknown handler", response
              $location.path '/500'
          return $q.reject(response)
    ])
]

app.run [
  '$rootScope'
  '$location'
  'Auth'
  ($rootScope, $location, Auth) ->
    $rootScope.$on "$routeChangeStart", (event, next, current) ->
      $rootScope.error = null
      next.access = 0 if next.access is undefined
      if (not Auth.authorize(next.access))
        if Auth.isLoggedIn()
          $location.path('/')
        else
          $location.path('/login')
]
