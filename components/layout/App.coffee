React = require("react")
LoginComponent = require("../LoginComponent.coffee")
ChatComponent = require("../ChatComponent.coffee")
Uri = require("jsuri")
URLResources = require("../../common/URLResources")

module.exports = React.createClass
  getInitialState: ->
    {user: null}

  componentWillMount: ->
    @URLResources = new URLResources()
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      @getCurrentUser()

  loginClicked: ->
    window.location.assign("#{ @URLResources.getLogicServerOrigin() }/login")

  getCurrentUser: ->
    @URLResources.readFromAPI "#{ @URLResources.getLogicServerOrigin() }/current_user", (response) =>
      @setState user: response

  render: ->
    if @state.user
      React.createElement ChatComponent, user:@state.user
    else
      React.createElement LoginComponent, loginClicked: @loginClicked
