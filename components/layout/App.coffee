React = require("react")
Uri = require("jsuri")
Router = require("react-router")
LoginComponent = React.createFactory require("../LoginComponent.coffee")
ChatComponent = React.createFactory require("../ChatComponent.coffee")
URLResources = require("../../common/URLResources")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

module.exports = React.createClass
  displayName: "App"

  mixins: [ Router.State, ReactStateMagicMixin ]

  statics:
    registerStore: AppStore

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      AppActions.fetchUser()
    newurl = "#{window.location.protocol}//#{window.location.host}#{window.location.pathname}"
    window.history.pushState path: newurl, '', newurl

  render: ->
    if @state.user
      ChatComponent user: @state.user, logoutClicked: AppActions.logout, currentRoom: @getParams().id
    else
      LoginComponent loginClicked: AppActions.login
