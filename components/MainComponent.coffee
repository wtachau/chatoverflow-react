React                = require("react")
io                   = require("socket.io-client")
Router               = require("react-router")
URLResources         = require("../common/URLResources")
FollowResources      = require("../common/FollowResources")
UserStore            = require("../stores/UserStore")
UserActions          = require("../actions/UserActions")
RoomStore            = require("../stores/RoomStore")
RoomActions          = require("../actions/RoomActions")
MentionActions       = require("../actions/MentionActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

RoomList        = React.createFactory require("./chat/RoomList")
HeaderComponent = React.createFactory require("./HeaderComponent")
MainComponent   = React.createFactory require("./MainComponent")
TopicSidebar    = React.createFactory require("./sidebar/TopicSidebar")
RouteHandler    = React.createFactory Router.RouteHandler

{ div, audio, source } = React.DOM


MainComponent = React.createClass
  displayName: "MainComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      room: RoomStore

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

    @socket.on "mention", ({user_id, username, room_id, text}) =>
      unless FollowResources.isFollowingRoom room_id, @state.user.user
        UserActions.followRoom room_id, @state.user.user
      @refs.plingsound.getDOMNode().play()
      MentionActions.setUnreadMentions room_id
      if document.title.match /(\d+)/
        document.title = document.title.replace /(\d+)/, (match) ->
          parseInt(match) + 1
      else
        document.title += " (1)"

    @socket.emit "subscribe mention",
      {username: @state.user.user.username}

  render: ->
    div {},
      HeaderComponent
        user: @state.user.user
      div {className: "chat"},
        TopicSidebar
          user: @state.user.user
        div {className: "chat-panel"},
          RouteHandler {socket: @socket}
      audio {ref: "plingsound"},
        source {src: "../../../assets/sounds/pling.wav", type: "audio/wav"}
        source {src: "../../../assets/sounds/pling.mp3", type: "audio/mp3"}

module.exports = MainComponent
