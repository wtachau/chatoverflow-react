React                = require("react")
Uri                  = require("jsuri")
Router               = require("react-router")
URLResources         = require("../../common/URLResources")
UserStore            = require("../../stores/UserStore")
UserActions          = require("../../actions/UserActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

TopicSidebar     = React.createFactory require("../sidebar/TopicSidebar")
LandingComponent = React.createFactory require("../LandingComponent")
LoginComponent   = React.createFactory require("../LoginComponent")
HeaderComponent  = React.createFactory require("../HeaderComponent")
MainComponent    = React.createFactory require("../MainComponent")
RouteHandler     = React.createFactory Router.RouteHandler

{ div } = React.DOM

module.exports = React.createClass
  displayName: "App"

  mixins: [ Router.State, Router.Navigation, ReactStateMagicMixin ]

  statics:
    registerStore: UserStore

  componentWillMount: ->
    jwt = new Uri(location.search).getQueryParamValue("jwt")
    if jwt
      sessionStorage.setItem('jwt', jwt)

    unless sessionStorage.getItem('jwt')
      sessionStorage.setItem('preLoginPath', window.location.pathname)

  componentDidMount: ->
    if sessionStorage.getItem('jwt')
      UserActions.fetchUser()
      UserActions.fetchUsers()

      preLoginPath = sessionStorage.getItem('preLoginPath')
      if preLoginPath and preLoginPath isnt ''
        @transitionTo preLoginPath
        sessionStorage.setItem('preLoginPath', '')

    newurl = "#{window.location.protocol}//\
              #{window.location.host}#{window.location.pathname}"
    window.history.pushState path: newurl, '', newurl

  render: ->
    if @state.user
      MainComponent {}
    else
      LandingComponent loginClicked: UserActions.login
