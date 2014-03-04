'use strict';

angular.module('dashboardApp').factory('Routes', [
    'Restangular'
    (Restangular) ->
        return {
            account: () ->
                Restangular.all('account')
            feeds: (id) ->
                Restangular.one('dashboard', id)
            feed: (id, feed) ->
                Restangular.one('dashboard', id).all(feed)
            prospects: (id, collection) ->
                if id?
                    if collection?
                        Restangular.one('prospects', id).all(collection)
                    else
                        Restangular.one('prospects', id)
                else
                    Restangular.all('prospects')
            listings: (mlsId, mlsNum) ->
                Restangular.one('mls', mlsId).one("mls-num", mlsNum)
            admin: (collection) ->
                if collection?
                    Restangular.all('admin').all(collection)
                else
                    Restangular.all('admin')
            setSessionHeaders: (user) ->
                Restangular.setDefaultHeaders({
                    'Session-Key': user.sessionKey
                    'Login-Key': user.loginKey
                    'User-Id': user.userId
                })
        }
])