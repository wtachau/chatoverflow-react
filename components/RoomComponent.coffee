React = require("react")
io = require("socket.io-client")

{ div, audio, source } = React.DOM
TopicSidebar = React.createFactory require("./sidebar/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
AskComponent = React.createFactory require("./AskComponent")
RoomList = React.createFactory require("./chat/RoomList")
URLResources = require("../common/URLResources")
FollowResources = require("../common/FollowResources")
ChatStore = require("../stores/ChatStore")
AppStore = require("../stores/AppStore")
ChatActions = require("../actions/ChatActions")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Router = require("react-router")

RoomComponent = React.createClass
  displayName: "RoomComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  username: -> @state.app.user.username

  pic_url: -> @state.app.user.pic_url

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message",
      ({id, user, room_id, text, created_at}) =>
        if room_id is @getParams().room_id
          ChatActions.pushNewMessage {vote_total: 0, user, id, room_id, text, created_at, isNewMessage: true}
          @scrollDownMessages()

    @socket.on "mention", ({user_id, username, room_id, text}) =>
      unless FollowResources.isFollowingRoom room_id, @state.app.user
        AppActions.followRoom room_id, @state.app.user
      @refs.plingsound.getDOMNode().play()
      AppActions.setUnreadMentions room_id

    @socket.emit "subscribe",
      {username: @username(), room: @getParams().room_id}

  scrollDownMessages: ->
    component = React.findDOMNode @refs.messageList
    if component
      component.scrollTop = component.scrollHeight

  componentWillReceiveProps: (newProps) ->
    unless @props.params.room_id is newProps.params.room_id
      @socket.emit "subscribe",
        {username: @username(), room: @getParams().room_id}
      ChatActions.setCurrentRoom parseInt @getParams().room_id
      ChatActions.fetchRecentMessages @getParams().room_id
      if @state.app.unread_mentions[parseInt @getParams().room_id]
        AppActions.setReadMentions @getParams().room_id    

  componentDidMount: ->
    setTimeout =>
      ChatActions.setCurrentRoom parseInt @getParams().room_id
      ChatActions.fetchRecentMessages @getParams().room_id
      if @state.app.unread_mentions[parseInt @getParams().room_id]
        AppActions.setReadMentions @getParams().room_id
        
  componentWillUnmount: ->
    @socket.removeAllListeners "chat message"
    @socket.removeAllListeners "mention"
    ChatActions.setCurrentRoom null

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @socket.emit "chat message",
        user:
          user_id: @state.app.user.id
          pic_url: @pic_url()
          username: @username()
        room_id: @getParams().room_id
        text: message.trim()
        mentions: mentions
    e.preventDefault()

  render: ->
    div {className: "messages-section"},
      MessageList
        originalPost: @state.chat.originalPost
        messages: @state.chat.messages
        currentRoom: @getParams().room_id
        ref: "messageList"
      ChatForm
        submitMessage: @submitMessage
        currentMessage: @state.chat.currentMessage
        users: @state.app.users
      audio {ref: "plingsound"},
        source {src: "../../../assets/sounds/pling.wav", type: "audio/wav"}
        source {src: "../../../assets/sounds/pling.mp3", type: "audio/mp3"}

module.exports = RoomComponent
