React = require("react")
Uri = require("jsuri")
Router = require("react-router")
RouteHandler = React.createFactory Router.RouteHandler
LoginComponent = React.createFactory require("../LoginComponent")
HeaderComponent = React.createFactory require("../HeaderComponent")
MainComponent = React.createFactory require("../MainComponent")
URLResources = require("../../common/URLResources")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
TopicSidebar = React.createFactory require("../sidebar/TopicSidebar")
{ div } = React.DOM

module.exports = React.createClass
  displayName: "App"

  mixins: [ Router.State, Router.Navigation, ReactStateMagicMixin ]

  statics:
    registerStore: AppStore

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

    unless sessionStorage.getItem('jwt')
      sessionStorage.setItem('preLoginPath', window.location.pathname)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      AppActions.fetchUser()
      AppActions.fetchUsers()

      unless sessionStorage.getItem('preLoginPath') is ''
        @transitionTo sessionStorage.getItem('preLoginPath')
        sessionStorage.setItem('preLoginPath', '')

    newurl = "#{window.location.protocol}//\
              #{window.location.host}#{window.location.pathname}"
    window.history.pushState path: newurl, '', newurl

  render: ->
    if @state.user
      MainComponent {}
    else
      LoginComponent loginClicked: AppActions.login
