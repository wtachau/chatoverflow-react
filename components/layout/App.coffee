React = require("react")
Uri = require("jsuri")
Router = require("react-router")
LoginComponent = React.createFactory require("../LoginComponent")
ChatComponent = React.createFactory require("../ChatComponent")
HeaderComponent = React.createFactory require("../HeaderComponent")
URLResources = require("../../common/URLResources")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
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
    newurl = "#{window.location.protocol}//\
              #{window.location.host}#{window.location.pathname}"
    window.history.pushState path: newurl, '', newurl

  render: ->
    if @state.user
      div {},
        HeaderComponent {}
        ChatComponent
          user: @state.user
          logoutClicked: AppActions.logout
          currentRoom: @getParams().room_id
          currentTopic: @getParams().topic_id
    else
      LoginComponent loginClicked: AppActions.login
