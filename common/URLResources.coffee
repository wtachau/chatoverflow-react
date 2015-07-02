Reqwest = require("reqwest")
URLResources = 
  
  getChatServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3001"
      when "staging" then "http://chat-overflow-node-staging.herokuapp.com"

  getLogicServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3000"
      when "staging" then "http://chat-overflow-rails-staging.herokuapp.com"

  callAPI:(url, method, data, successFunction, errorFunction) ->
    Reqwest
      url: @getLogicServerOrigin() + url
      type: "json"
      method: method
      data: JSON.stringify data
      contentType: "application/json"
      headers: { "Authorization": sessionStorage.getItem("jwt") }
      success: successFunction
      error: errorFunction 

  readFromAPI: (url, successFunction, errorFunction) ->
    @callAPI(url, "get", null, successFunction, errorFunction)

  writeToAPI: (url, data, successFunction, errorFunction) ->
    @callAPI(url, "post", data, successFunction, errorFunction)

  putFromAPI: (url, successFunction, errorFunction) ->
    Reqwest
      url: @getLogicServerOrigin() + url
      type: 'json'
      method: 'put'
      contentType: 'application/json'
      headers: { 'Authorization': sessionStorage.getItem("jwt") }
      success: successFunction
      error: errorFunction

module.exports = URLResources
