React = require("react")
LoginComponent = require("../LoginComponent.coffee")
ChatComponent = require("../ChatComponent.coffee")
Uri = require("jsuri")
Reqwest = require("reqwest")

Router = require("react-router")
RouteHandler = Router.RouteHandler

module.exports = React.createClass
  getInitialState: ->
    {user: null}

  getChatServerOrigin: ->
    switch process.env.NODE_ENV
      when 'development' then "http://127.0.0.1:3001"
      when 'staging' then "http://chat-overflow-node-staging.herokuapp.com"

  getLogicServerOrigin: ->
    switch process.env.NODE_ENV
      when 'development' then "http://127.0.0.1:3000"
      when 'staging' then "http://chat-overflow-rails-staging.herokuapp.com"

  loginClicked: ->
    window.location.assign("#{ @getLogicServerOrigin() }/login")

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      @getCurrentUser()

  getCurrentUser: ->
    @readFromAPI "#{ @getLogicServerOrigin() }/current_user", (response) =>
      @setState user: response

  readFromAPI: (url, successFunction) ->
    Reqwest
      url: url,
      type: 'json',
      method: 'get',
      contentType: 'application/json',
      headers: { 'Authorization': sessionStorage.getItem("jwt") }
      success: successFunction,
      error: (error) ->
        console.error(url, error['response']);
        location = '/';

  render: ->
    if @state.user
      React.createElement ChatComponent, user:@state.user, readFromAPI:@readFromAPI, getLogicServerOrigin:@getLogicServerOrigin, getChatServerOrigin:@getChatServerOrigin
    else
      React.createElement LoginComponent, loginClicked: @loginClicked
