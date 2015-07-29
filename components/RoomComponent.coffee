React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./sidebar/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
AskComponent = React.createFactory require("./AskComponent")
RoomList = React.createFactory require("./chat/RoomList")
URLResources = require("../common/URLResources")
FollowResources = require("../common/FollowResources")
RoomStore = require("../stores/RoomStore")
UserStore = require("../stores/UserStore")
MentionStore = require("../stores/MentionStore")
ThreadStore = require("../stores/ThreadStore")
RoomActions = require("../actions/RoomActions")
ThreadActions = require("../actions/ThreadActions")
UserActions = require("../actions/UserActions")
MentionActions = require("../actions/MentionActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Router = require("react-router")

RoomComponent = React.createClass
  displayName: "RoomComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      room: RoomStore
      user: UserStore
      mention: MentionStore
      thread: ThreadStore
    willTransitionFrom: (transition, component) ->
      component.setMessage ""

  getInitialState: ->
    message: ""

  setMessage: (message) ->
    @setState message: message

  pic_url: -> @state.user.user.pic_url

  componentWillMount: ->
    @props.socket.on "chat message",
      ({id, user, room_id, text, created_at}) =>
        if room_id is @getParams().room_id
          ThreadActions.pushNewMessage {vote_total: 0, user, id, room_id, text, created_at, isNewMessage: true}
          @scrollDownMessages()

    @props.socket.emit "subscribe room",
      {room: @getParams().room_id}

  scrollDownMessages: ->
    component = React.findDOMNode @refs.messageList
    if component
      component.scrollTop = component.scrollHeight

  componentWillReceiveProps: (newProps) ->
    unless @props.params.room_id is newProps.params.room_id
      @setState message: ""
      @props.socket.emit "subscribe room", room: @getParams().room_id
      ThreadActions.setCurrentRoom parseInt @getParams().room_id
      ThreadActions.fetchRecentMessages @getParams().room_id
      @readMention()

  componentDidMount: ->
    setTimeout =>
      ThreadActions.setCurrentRoom parseInt @getParams().room_id
      ThreadActions.fetchRecentMessages @getParams().room_id
      @readMention()

  readMention: ->
    room_id = parseInt @getParams().room_id
    if @state.mention.unread[room_id]
      MentionActions.setReadMentions room_id
      titleMentions = document.title.match /(\d+)/
      if titleMentions
        if parseInt(titleMentions[0]) > 1
          document.title.replace /(\d+)/, (match) ->
            parseInt(match) - 1
        else
          document.title = document.title.slice(0, -4)

  componentWillUnmount: ->
    @props.socket.removeAllListeners "chat message"
    ThreadActions.setCurrentRoom null

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @props.socket.emit "chat message",
        user:
          user_id: @state.user.user.id
          pic_url: @pic_url()
          username: @state.user.user.username
        room_id: @getParams().room_id
        text: message.trim()
        mentions: mentions
    e.preventDefault()

  render: ->
    div {className: "messages-section"},
      MessageList
        originalPost: @state.thread.originalPost or {}
        messages: @state.thread.messages
        currentRoom: @getParams().room_id
        ref: "messageList"
      ChatForm
        submitMessage: @submitMessage
        setMessage: @setMessage
        message: @state.message
        users: @state.user.users
      @chatForm
module.exports = RoomComponent
