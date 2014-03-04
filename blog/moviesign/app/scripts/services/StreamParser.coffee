'use strict'

angular.module('dashboardApp').factory('StreamParser', [() ->
    # Service logic

    testExist = (x) ->
        x? and not _.isEmpty(x)

    userTypeComparator = (event) ->
        switch event.type
            when "prospect-property-viewed"
                "#{event.prospectId}_#{event.type}_#{event.mls}_#{event.mlsNum}"
            when "prospect-searched-properties"
                "#{event.prospectId}_#{event.type}_
                    #{searchSummary(event.search).join(' ').replace(/[^a-zA-Z0-9 ]/g, "").split(' ').join('_')}"
            when "prospect-property-inquiry-submitted", "prospect-showing-request-submitted"
                "#{event.prospectId}_#{event.type}_#{event.mls}_#{event.mlsNum}"
            when "prospect-area-report-request-submitted"
                "#{event.prospectId}_#{event.type}_#{event.area}"
            when "prospect-contact-form-submitted"
                "#{event.prospectId}_#{event.type}"
            # @TODO: add watch list and saved search handlers

    rollupOld = (stream) ->
        _.chain(stream)
            .groupBy((item) ->
                new Date(item.time).toDateString())
            .map((item) ->
                _.values(_.groupBy(item, (i) ->
                    userTypeComparator(i))))
            .flatten(true)
            .sortBy((item) ->
               -item.time)
            .value()

    rollup = (stream) ->
        byProspect = _.groupBy(stream, (item) ->
            item.prospectId
        )
        latests = _.map(byProspect, (events, prospId) ->
            events[0]
        )
        sorted = _.sortBy(latests, (item) ->
            -item.time
        )
        sorted

    searchSummary = (search) ->
        ret = []
        if testExist(search.query)
            ret.push search.query
        else if testExist(search.subdivision) and testExist(search.city) and testExist(search.state)
            ret.push search.subdivision
            ret.push search.city
            ret.push search.state
        else if testExist(search.city) and testExist(search.state) and testExist(search.zip)
            ret.push search.city
            ret.push "#{search.state} #{search.zip}"
        else if testExist(search.county) and testExist(search.state)
            ret.push search.county
            ret.push search.state
        else if testExist(search.zip)
            ret.push search.zip
        else if testExist(search.schools)
            ret.push search.schools
        else if testExist(search.county)
            ret.push search.county
        else if search.location?
            return "map"
        else if testExist(search.state)
            ret.push search.state
        _.flatten(ret)

    processDashboardEvent = (item) ->
        switch item.type
            when "prospect-property-viewed"
                if item.propertyInfo? and item.prospectInfo?
                    return item
                else
                    return null
            when "prospect-searched-properties"
                if item.search? and item.prospectInfo?
                    return item
                else
                    return null
            when "prospect-property-inquiry-submitted", "prospect-showing-request-submitted", "prospect-area-report-request-submitted", "prospect-contact-form-submitted"
                return item
            # @TODO: add watch list and saved search handlers
            else
                console.log("Event has unknown type", item)
                return null

    processProfileEvent = (item) ->
        switch item.type
            when "prospect-property-viewed"
                if item.propertyInfo?
                    return item
                else
                    return null
            when "prospect-searched-properties"
                if item.search?
                    return item
                else
                    return null
            when "prospect-property-inquiry-submitted", "prospect-showing-request-submitted", "prospect-area-report-request-submitted", "prospect-contact-form-submitted"
                return item
            # @TODO: add watch list and saved search handlers
            else
                console.log("Event has unknown type", item)
                return null

    # Public API here
    return {
        processDashboardEvent: processDashboardEvent
        processProfileEvent: processProfileEvent
        rollup: rollup
        rollupOld: rollupOld
    }
])