Reqwest = require("reqwest")

URLResources =
  
  getChatServerOrigin: ->
    switch process.env.NODE_ENV
      when 'development' then "http://127.0.0.1:3001"
      when 'staging' then "http://chat-overflow-node-staging.herokuapp.com"

  getLogicServerOrigin: ->
    switch process.env.NODE_ENV
      when 'development' then "http://127.0.0.1:3000"
      when 'staging' then "http://chat-overflow-rails-staging.herokuapp.com"

  readFromAPI: (url, successFunction) ->
    Reqwest
      url: @getLogicServerOrigin() + url,
      type: 'json',
      method: 'get',
      contentType: 'application/json',
      headers: { 'Authorization': sessionStorage.getItem("jwt") }
      success: successFunction,
      error: (error) ->
        console.error(url, error['response'])
        location = '/'

module.exports = URLResources
