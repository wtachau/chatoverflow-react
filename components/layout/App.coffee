React = require("react")
LoginComponent = require("../LoginComponent.coffee")
ChatComponent = require("../ChatComponent.coffee")
Uri = require("jsuri")
Reqwest = require("reqwest")

module.exports = React.createClass
  getInitialState: ->
    {user: null}

  loginClicked: ->
    location = if process.env.NODE_ENV == "development" then "http://localhost:3000/login"
    window.location.assign(location)

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      @getCurrentUser()

  getCurrentUser: ->
    @readFromAPI 'http://localhost:3000/current_user', (response) =>
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
      React.createElement ChatComponent
    else
      React.createElement LoginComponent, loginClicked: @loginClicked
