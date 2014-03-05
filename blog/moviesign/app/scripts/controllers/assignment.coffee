'use strict'

angular.module('dashboardApp')
  .controller 'AssignmentCtrl', [
    '$scope'
    'Routes'
    'prospects'
    'agents'
    ($scope, Routes, prospects, agents) ->
      $scope.getNumber = (num) -> [0...parseInt(num)]
      getMoreAgents = (lastId) ->
        Routes.admin().all('prospects').all('unassigned').getList({limit: 100, start: lastId}).then(
          (resp) -> 
            _.each(resp.data, (prospect) ->
              _.each(prospect, ((v,k) ->
                this[k] = '' if not v?
              ), prospect)
              $scope.prospects.push(prospect)
            )
            if not _.isEmpty(resp.data)
              getMoreAgents(resp.data[resp.data.length-1].prospectId)
        )        

      $scope.colOpts = globals.prospect.columns
      $scope.columns = globals.admin.columns
      $scope.prospects = prospects
      getMoreAgents(prospects[prospects.length-1].prospectId)
      $scope.agents = agents

      $scope.gridOpts =
        data: 'prospects'
        columnDefs: _.chain($scope.colOpts)
          .pick($scope.columns)
          .map((co) -> _.extend co, {visible: true})
          .value()
        enableColumnReordering: true
        enableColumnResize: true
        showColumnMenu: false #will re-enable when column selection is available
        showFilter: true
        showFooter: true
        showGroupPanel: false #will re-enable when ngGrid 2.0.8 is released
        sortInfo:
          fields: ['prospectLastActivity']
          directions: ['desc']
  ]
