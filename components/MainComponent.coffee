React = require("react")
io = require("socket.io-client")
Router = require("react-router")

URLResources = require("../common/URLResources")
FollowResources = require("../common/FollowResources")
AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ChatStore = require("../stores/ChatStore")
ChatActions = require("../actions/ChatActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

RouteHandler = React.createFactory Router.RouteHandler
RoomList = React.createFactory require("./chat/RoomList")
HeaderComponent = React.createFactory require("./HeaderComponent")
MainComponent = React.createFactory require("./MainComponent")
TopicSidebar = React.createFactory require("./sidebar/TopicSidebar")

{ div, audio, source } = React.DOM


MainComponent = React.createClass
  displayName: "MainComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

    @socket.on "mention", ({user_id, username, room_id, text}) =>
      unless FollowResources.isFollowingRoom room_id, @state.app.user
        AppActions.followRoom room_id, @state.app.user
      @refs.plingsound.getDOMNode().play()
      AppActions.setUnreadMentions room_id
      if document.title.match /(\d+)/
        document.title = document.title.replace /(\d+)/, (match) ->
          parseInt(match) + 1
      else
        document.title += " (1)"


    @socket.emit "subscribe mention",
      {username: @state.app.user.username}

  render: ->
    div {},
      HeaderComponent
        user: @state.app.user
      div {className: "chat"},
        TopicSidebar
          user: @state.app.user
        div {className: "chat-panel"},
          RouteHandler {socket: @socket}
      audio {ref: "plingsound"},
        source {src: "../../../assets/sounds/pling.wav", type: "audio/wav"}
        source {src: "../../../assets/sounds/pling.mp3", type: "audio/mp3"}

module.exports = MainComponent
