React = require("react")
LoginComponent = require("../LoginComponent.coffee")
ChatComponent = require("../ChatComponent.coffee")
Uri = require("jsuri")
URLResources = require("../../common/URLResources")

module.exports = React.createClass

  getInitialState: ->
    {user: null}

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      @getCurrentUser()
    newurl = "#{window.location.protocol}//#{window.location.host}"
    window.history.pushState path:newurl, '', newurl

  loginClicked: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/login")

  logoutClicked: ->
    @setState user: null
    sessionStorage.setItem('jwt', '')

  getCurrentUser: ->
    URLResources.readFromAPI "/current_user", (response) =>
      @setState user: response

  render: ->
    if @state.user
      React.createElement ChatComponent, user:@state.user, logoutClicked: @logoutClicked
    else
      React.createElement LoginComponent, loginClicked: @loginClicked
