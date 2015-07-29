Reqwest = require("reqwest")

URLResources =
  getChatServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3001"
      when "staging" then "http://chatsignal-node-staging.herokuapp.com"
      when "production" then "http://chatsignal-node-production.herokuapp.com"

  getLogicServerOrigin: ->
    switch process.env.NODE_ENV
      when "development" then "http://127.0.0.1:3000"
      when "staging" then "http://chatsignal-rails-staging.herokuapp.com"
      when "production" then "http://chatsignal-rails-production.herokuapp.com"

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
    console.error error

module.exports = URLResources
