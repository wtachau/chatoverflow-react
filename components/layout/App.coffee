React = require("react")
Uri = require("jsuri")
Router = require("react-router")
RouteHandler = React.createFactory Router.RouteHandler
LoginComponent = React.createFactory require("../LoginComponent")
ChatComponent = React.createFactory require("../TopicComponent")
HeaderComponent = React.createFactory require("../HeaderComponent")
URLResources = require("../../common/URLResources")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
TopicSidebar = React.createFactory require("../sidebar/TopicSidebar")
{ div } = React.DOM

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
      AppActions.fetchUsers()

    newurl = "#{window.location.protocol}//\
              #{window.location.host}#{window.location.pathname}"
    window.history.pushState path: newurl, '', newurl

  render: ->
    if @state.user
      div {},
        HeaderComponent {}
        div {className: "chat"},
          TopicSidebar
            user: @state.user
          div {className: "chat-panel"},
            RouteHandler {}
    else
      LoginComponent loginClicked: AppActions.login
