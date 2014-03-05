((exports) ->
    exports.prospect =
        status: [
            "Active Client"
            "Appointment Scheduled"
            "Closed"
            "Contacted"
            "Contacted - Emailed"
            "Contacted - Texted"
            "Contacted - Voicemail"
            "Disqualified - Financial"
            "Disqualified - Has Agent"
            "Invalid"
            "Needs Follow-up"
            "New"
            "Non-responsive"
            "Not a good fit"
            "Not in my area"
            "Offer"
            "Rental"
            "Responsive - Search Setup"
            "Under Contract"
        ]
        columns:
            action:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        <a href="/#/prospect/{{row.getProperty(\'prospectId\')}}">
                            View
                        </a>
                    </div>'
                displayName: "Actions"
                field: "action"
                groupable: false
                sortable: false
                system: true
                width: '*'
            dripStatus:
                displayName: "Drip Status"
                field: "dripStatus"
                system: false
                width: 'auto'
            email:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        <a href="mailto:{{row.getProperty(col.field)}}">
                            {{row.getProperty(col.field)}}
                        </a>
                    </div>'
                displayName: "Email"
                field: "email"
                groupable: false
                system: true
                width: '**'
            firstActivity:
                aggLabelFilter: "date"
                cellFilter: "nullDate"
                displayName: "First Activity"
                field: "prospectFirstActivity"
                groupable: false
                system: false
                width: '**'
            firstName:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        <a href="/#/prospect/{{row.getProperty(\'prospectId\')}}">
                            {{row.getProperty(col.field)}}
                        </a>
                    </div>'
                displayName: "First Name"
                field: "firstName"
                groupable: false
                system: true
                width: '*'
            grade:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        <rating value="row.getProperty(col.field)" max="5" readonly="true"></rating>
                    </div>'
                displayName: "Grade"
                field: "grade"
                system: true
                width: '*'
            lastAction:
                displayName: "Last Action"
                field: "lastAction"
                system: true
                width: 'auto'
            lastActivity:
                aggLabelFilter: "date"
                cellFilter: "nullDate"
                displayName: "Last Active"
                field: "prospectLastActivity"
                groupable: false
                system: true
                width: '**'
            lastName:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        <a href="/#/prospect/{{row.getProperty(\'prospectId\')}}">
                            {{row.getProperty(col.field)}}
                        </a>
                  </div>'
                displayName: "Last Name"
                field: "lastName"
                groupable: false
                system: true
                width: '*'
            leadStatus:
                displayName: "Status"
                field: "status"
                system: true
                width: '*'
            numCommunications:
                displayName: "Communications"
                field: "numCommunications"
                system: false
                width: 'auto'
            numFavoritedProperties:
                displayName: "Favorited Properties"
                field: "numFavoritedProperties"
                system: false
                width: 'auto'
            numSavedSearches:
                displayName: "Saved Searches"
                field: "numSavedSearches"
                system: false
                width: 'auto'
            numWatchLists:
                displayName: "Watch Lists"
                field: "numWatchLists"
                system: false
                width: 'auto'
            phone:
                cellTemplate: '
                    <div class="ngCellText" data-ng-class="col.colIndex()">
                        {{row.getProperty(col.field) | checkmark }}
                    </div>'
                displayName: "Phone?"
                field: "phone"
                groupable: false
                system: true
                width: 56
            pricePoint:
                displayName: "Approx. Price Point"
                field: "pricePoint"
                system: false
                width: 'auto'
            referrer:
                displayName: "Referrer"
                field: "referrer"
                system: false
                width: 'auto'
            score:
                displayName: "Score"
                field: "score"
                system: true
                width: 'auto'
            searchArea:
                displayName: "Search Area"
                field: "searchArea"
                system: false
                width: 'auto'
            sparkline:
                displayName: "Sparkline"
                field: "sparkline"
                groupable: false
                system: false
                width: 'auto'
            upcomingTask:
                displayName: "Upcoming Task"
                field: "upcomingTask"
                system: false
                width: 'auto'
            whichDrip:
                displayName: "Drip Track"
                field: "whichDrip"
                system: false
                width: 'auto'

    exports.user =
        columns: [
            'firstName'
            'lastName'
            'email'
            'phone'
            'grade'
            'leadStatus'
            'lastActivity'
            'firstActivity'
            'action'
        ]

    exports.admin =
        columns: [
            'firstName'
            'lastName'
            'email'
            'phone'
            'grade'
            'leadStatus'
            'lastActivity'
            'firstActivity'
        ]

    exports.google =
        mapOpts:
            zoom: 8
            center: new google.maps.LatLng(33.765449, -84.418945)
            mapTypeId: google.maps.MapTypeId.ROADMAP
            mapTypeControlOptions:
                mapTypeIds: [
                    google.maps.MapTypeId.HYBRID
                    google.maps.MapTypeId.ROADMAP
                    google.maps.MapTypeId.SATELLITE
                    google.maps.MapTypeId.TERRAIN
                ]
            scrollwheel: false
            disableDoubleClickZoom: true
            streetViewControl: false
            panControl: false
            scaleControl: true
            zoomControl: true
            zoomControlOptions:
                style: google.maps.ZoomControlStyle.SMALL

    exports.noPhoto =
        sizes:
            original:
                url: "http://clickscape.com/images/no-photo-large.png"
                width: 640
                height: 480
            thumb:
                url: "http://clickscape.com/images/no-photo-sm.jpg"
                width: 60
                height: 60
            small:
                url: "http://clickscape.com/images/no-photo.png"
                width: 222
                height: 166
)(if typeof exports is "undefined" then this["globals"] = {} else exports)
