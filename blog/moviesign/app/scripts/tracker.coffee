# IE Compatability Shims

if Event.prototype.preventDefault?
    Event.prototype.csPreventDefault = Event.prototype.preventDefault
else
    Event.prototype.csPreventDefault = () ->
        this.returnValue = false

if Event.prototype.stopPropogation?
    Event.prototype.csStopPropogation = Event.prototype.stopPropogation
else
    Event.prototype.csStopPropogation = () ->
        this.cancelBubble = true

if "test".startsWith?
    startsWith = (str, searchString, position) ->
        str.startsWith(searchString, position)
else
    startsWith = (str, searchString, position) ->
        position ?= 0
        str.indexOf(searchString, position) == position


root = exports ? this

# cookie functions adapted from:
# https://developer.mozilla.org/en-US/docs/Web/API/document.cookie?redirectlocale=en-US&redirectslug=DOM%2Fdocument.cookie

getCookie = (name) ->
    encName = encodeURIComponent(name).replace(/[\-\.\+\*]/g, "\\$&")
    matchRe = new RegExp("(?:(?:^|.*;)\\s*" + encName + "\\s*\\=\\s*([^;]*).*$)|^.*$")
    encVal = document.cookie.replace(matchRe, "$1")
    if encVal
        decodeURIComponent(encVal)

setCookie = (name, value, opts) ->
    opts ?= {}

    if opts.expires
        switch opts.expires.constructor
            when Number
                expires =
                    if opts.expires == Infinity
                        "; expires=Fri, 31 Dec 9999 23:59:59 GMT"
                    else
                        "; max-age=" + opts.expires
            when String
                expires = "; expires=#{opts.expires}"
            when Date
                expires = "; expires=#{opts.expires.toUTCString}"
            else
                expires = ""
    else
        expires = ""

    domain =
        if opts.domain
            "; domain=#{opts.domain}"
        else
            ""
    path =
        if opts.path
            "; path=#{opts.path}"
        else
            ""
    secure =
        if opts.secure
            "; secure"
        else
            ""
    cookieStr = "#{encodeURIComponent(name)}=#{encodeURIComponent(value)}#{expires}#{domain}#{path}#{secure}"
    document.cookie = cookieStr

deleteCookie = (name, opts) ->
    opts ?= {}

    domain =
        if opts.domain
            "; domain=#{opts.domain}"
        else
            ""
    path =
        if opts.path
            "; path=#{opts.path}"
        else
            ""
    secure =
        if opts.secure
            "; secure"
        else
            ""
    cookieStr = "#{encodeURIComponent(name)}=; expires=Thu, 01 Jan 1970 00:00:00 GMT#{domain}#{path}#{secure}"
    document.cookie = cookieStr

addListener = (elt, event, cb) ->
    if elt.addEventListener
        elt.addEventListener(event, cb, false)
    else
        elt.attachEvent("on#{event}", cb)

buildRequest = (method, url) ->
    console.log("buildRequest(#{method}, #{url})")
    if XMLHttpRequest?
        xhr = new XMLHttpRequest()
        if "withCredentials" of xhr
            xhr.open(method, url, true)
            xhr
        else if XDomainRequest?
            xhr = new XDomainRequest()
            xhr.open(method, url)
            xhr
        else
            null
    else
        null

makeRadio = (name, id, value) ->
    elt = document.createElement("input")
    elt.setAttribute("type", "radio")
    elt.setAttribute("value", value)
    elt.setAttribute("name", name)
    elt.setAttribute("id", id)
    elt


makeCheckbox = (name, id, value) ->
    elt = document.createElement("input")
    elt.setAttribute("type", "checkbox")
    elt.setAttribute("value", value)
    elt.setAttribute("name", name)
    elt.setAttribute("id", id)
    elt

makeLabel = (forId, text) ->
    lbl = document.createElement("label")
    lbl.setAttribute("for", forId)
    lbl.innerHTML = text
    lbl

class Servo

    constructor: (@acctId, config) ->
        if config.idCookie?
            @idCookie = config.idCookie
        else
            @idCookie = "tsv#{@acctId}"

        @endpointBase = if config.endpoint then config.endpoint else "http://app.clickscapeagents.com/api"

        @vid = getCookie(@idCookie)
        if-not @vid?
            @getVisitorId()


    apiRequest: (method, url, paramsOrCallback, callback) ->
        if callback?
            params = paramsOrCallback
        else
            params = null
            callback = paramsOrCallback

        console.log("apiRequest(#{method}, #{url}, #{params})")
        if params?
            params.iid = @acctId

            if startsWith(url, "http://") || startsWith(url, "https://")
                reqUrl = url
            else
                reqUrl = "#{@endpointBase}#{url}"

            switch method
                when "GET"
                    parts = []
                    for k, v of params
                        parts.push("#{encodeURIComponent(k)}=#{encodeURIComponent(v)}")
                    reqUrl += "?" + parts.join("&")

                    req = buildRequest("GET", reqUrl)
                    req.onload = callback
                    req.send()
                when "POST"
                    parts = []
                    for k, v of params
                        parts.push("#{encodeURIComponent(k)}=#{encodeURIComponent(v)}")
                    body = parts.join("\r\n")

                    req = buildRequest("POST", reqUrl)
                    req.setRequestHeader("Content-Type", "text/plain")
                    req.onload = callback

                    req.send(body)
        else
            req = buildRequest(method, "#{@endpointBase}#{url}?iid=#{@acctId}")
            req.onload = callback
            req.send()

    getVisitorId: () ->
        @apiRequest("GET", "/tr/id", (evt) =>
            req = evt.target
            response = req.responseText
            if response
                parsed = JSON.parse(response)
                @vid = parsed.id
                setCookie(@idCookie, @vid, {expires: Infinity})
        )

    profilingQuestions: (elt, cb) ->
        if elt
            @apiRequest("GET", "/tr/pqs", {vid: @vid}, (evt) =>
                req = evt.target
                response = req.responseText
                if response
                    parsed = JSON.parse(response)
                    @questions = parsed

                    container = document.createElement("ul")
                    container.setAttribute("class", "profile-questions")

                    for question in @questions
                        qelt = @setupQuestion(question)
                        container.appendChild(qelt)

                    elt.appendChild(container)

                    if cb
                        cb(elt, @questions.length)
            )

    setupQuestion: (question) ->
        valueElts = []

        qelt = document.createElement("li")
        qelt.setAttribute("class", "profile-question")

        qtext = document.createElement("div")
        qtext.setAttribute("class", "profile-question-text")
        qtext.innerHTML = question.questionText

        qfrmcnt = document.createElement("div")

        qfrm = document.createElement("form")
        qfrm.setAttribute("class", "profile-question-form")

        qfrmcnt.appendChild(qfrm)

        valelt = document.createElement("pre")
        qfrmcnt.appendChild(valelt)

        prevVal = null
        submitfn = (evt) =>
            str = "submitfn for question #{question.questionId}\n"

            if question.allowMultiple
                newVal = []
            else
                newVal = null

            for elt in valueElts
                if elt.checked
                    if question.allowMultiple
                        newVal.push(elt.value)
                    else
                        newVal = elt.value

            if newVal != prevVal
                str += "Value changed from #{prevVal} to #{newVal}"
                prevVal = newVal

#            req = buildRequest("POST", question.answerUrl)
#            req.setRequestHeader("Content-Type", "text/plain")

            if question.allowMultiple
                valStr = newVal.join(",")
            else
                valStr = newVal

            @apiRequest("POST", question.answerUrl, {answer: valStr, vid: @vid}, (evt) ->
                req = evt.target
                console.log req.responseText
            )

            if-not question.allowMultiple
                qthanks = document.createElement("div")
                qthanks.setAttribute("class", "question-thanks")
                qthanks.innerHTML = "Thank you. Your answer has been submitted. "

                replaceFrm = (evt) ->
                    qfrmcnt.removeChild(qthanks)
                    qfrmcnt.appendChild(qfrm)
                    evt.csPreventDefault()

                qreanswer = document.createElement("a")
                qreanswer.setAttribute("class", "question-reanswer")
                qreanswer.innerHTML = "Change answer."
                addListener(qreanswer, "click", replaceFrm)

                qthanks.appendChild(qreanswer)

                qfrmcnt.removeChild(qfrm)
                qfrmcnt.appendChild(qthanks)

            valelt.innerHTML = str


        switch question.questionType
            when "boolean"
                makeInput = makeRadio
                qopts = {"1": "Yes", "0": "No"}
            when "pick"
                if question.allowMultiple
                    makeInput = makeCheckbox
                else
                    makeInput = makeRadio

                qopts = question.pickOptions

        for optVal, optText of qopts
            optgrp = document.createElement("fieldset")

            optid = "qr#{question.questionId}_#{optVal}"
            optelt = makeInput("qr#{question.questionId}", optid, optVal)
            optlbl = makeLabel(optid, optText)

            optgrp.appendChild(optelt)
            optgrp.appendChild(optlbl)

            valueElts.push(optelt)
            qfrm.appendChild(optgrp)
            addListener(optelt, "click", submitfn)


        qelt.appendChild(qtext)

        qelt.appendChild(qfrmcnt)

        qelt

# window.Servo = Servo

if root.servoAcct?
    window.servo = new Servo(root.servoAcct, root.servoConfig ? {})