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

  pic_url: -> @state.app.user.pic_url

  componentWillMount: ->
    @props.socket.on "chat message",
      ({id, user, room_id, text, created_at}) =>
        if room_id is @getParams().room_id
          ChatActions.pushNewMessage {vote_total: 0, user, id, room_id, text, created_at, isNewMessage: true}
          @scrollDownMessages()

    @props.socket.emit "subscribe room",
      {room: @getParams().room_id}

  scrollDownMessages: ->
    component = React.findDOMNode @refs.messageList
    if component
      component.scrollTop = component.scrollHeight

  componentWillReceiveProps: (newProps) ->
    unless @props.params.room_id is newProps.params.room_id
      @props.socket.emit "subscribe",
        {username: @state.app.user.username, room: @getParams().room_id}
      ChatActions.setCurrentRoom parseInt @getParams().room_id
      ChatActions.fetchRecentMessages @getParams().room_id
      @readMention()

  componentDidMount: ->
    setTimeout =>
      ChatActions.setCurrentRoom parseInt @getParams().room_id
      ChatActions.fetchRecentMessages @getParams().room_id
      @readMention()

  readMention: ->
    if @state.app.unread_mentions[parseInt @getParams().room_id]
      AppActions.setReadMentions @getParams().room_id
      titleMentions = document.title.match /(\d+)/
      if titleMentions
        if parseInt(titleMentions[0]) > 1
          document.title.replace /(\d+)/, (match) ->
            parseInt(match) - 1
        else
          document.title = document.title.slice(0, -4)

  componentWillUnmount: ->
    @props.socket.removeAllListeners "chat message"
    ChatActions.setCurrentRoom null

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @props.socket.emit "chat message",
        user:
          user_id: @state.app.user.id
          pic_url: @pic_url()
          username: @state.app.user.username
        room_id: @getParams().room_id
        text: message.trim()
        mentions: mentions
    e.preventDefault()

  render: ->
    div {className: "messages-section"},
      MessageList
        originalPost: @state.chat.originalPost or {}
        messages: @state.chat.messages
        currentRoom: @getParams().room_id
        ref: "messageList"
      ChatForm
        submitMessage: @submitMessage
        currentMessage: @state.chat.currentMessage
        users: @state.app.users

module.exports = RoomComponent
