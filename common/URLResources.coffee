Reqwest = require("reqwest")
AppActions = require ("../actions/AppActions")

URLResources =
  getChatServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3001"
      when "staging" then "http://chat-overflow-node-staging.herokuapp.com"

  getLogicServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3000"
      when "staging" then "http://chat-overflow-rails-staging.herokuapp.com"

  callAPI:(url, method, data, successFunction) ->
    Reqwest
      url: @getLogicServerOrigin() + url
      type: "json"
      method: method
      data: JSON.stringify data
      contentType: "application/json"
      headers: { "Authorization": sessionStorage.getItem("jwt") }
      success: successFunction
      error: @logError

  readFromAPI: (url, successFunction) ->
    @callAPI(url, "get", null, successFunction)

  logError: (error) ->
    console.log "ERROR: #{error}"
    AppActions.failure error

module.exports = URLResources
