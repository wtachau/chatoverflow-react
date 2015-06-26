React = require("react")
Uri = require("jsuri")
Router = require("react-router")
LoginComponent = React.createFactory require("../LoginComponent.coffee")
ChatComponent = React.createFactory require("../ChatComponent.coffee")
URLResources = require("../../common/URLResources")

module.exports = React.createClass

  mixins: [ Router.State ],

  getInitialState: ->
    {user: null}

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      @getCurrentUser()
    newurl = "#{window.location.protocol}//#{window.location.host}#{window.location.pathname}"
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
      ChatComponent user:@state.user, logoutClicked: @logoutClicked, currentRoom: @getParams().id
    else
      LoginComponent loginClicked: @loginClicked
