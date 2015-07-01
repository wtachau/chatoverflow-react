React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./chat/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
HomeComponent = React.createFactory require("./HomeComponent")
URLResources = require("../common/URLResources")
ChatStore = require("../stores/ChatStore")
AppStore = require("../stores/AppStore")
ChatActions = require("../actions/ChatActions")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

ChatComponent = React.createClass
  displayName: "ChatComponent"

  propTypes:
    user: React.PropTypes.shape
      username: React.PropTypes.string.isRequired
      id: React.PropTypes.number.isRequired
      name: React.PropTypes.string
    logoutClicked: React.PropTypes.func.isRequired
    currentRoom: React.PropTypes.string

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores: 
      chat: ChatStore
      app: AppStore

  username: ->
    @props.user.name or @props.user.username

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message", ({user_id, username, room_id, text}) =>
      if room_id == @props.currentRoom
        newList = @state.chat.messages
        newList.push {username, text}
        ChatActions.setMessagesList newList

  componentDidMount: ->
    ChatActions.fetchTopics()
    AppActions.fetchUsers()
    if @props.currentRoom
      ChatActions.fetchRoomHistory @props.currentRoom

  componentWillReceiveProps: (nextProps) ->
    unless nextProps.currentRoom is @props.currentRoom
      @socket.emit "subscribe", {username: @props.username, room: nextProps.currentRoom}
      @socket.emit "unsubscribe", {username: @props.username, room: @props.currentRoom}
      ChatActions.fetchRoomHistory nextProps.currentRoom

  submitMessage: (e, message) ->
    unless message is "" 
      @socket.emit "chat message", { user_id: @props.user.id, username: @username(), room_id: @props.currentRoom, "text": message.trim() }
    e.preventDefault()

  render: ->
    mainSection = if @props.currentRoom then (
      div {},
        MessageList {messages: @state.chat.messages}
        ChatForm {submitMessage: @submitMessage, currentMessage: @state.chat.currentMessage, users: @state.app.users} )
    else
      HomeComponent {}

    div {className: "chat"},
      TopicSidebar {topics: @state.chat.topics, user: @state.app.user}
      mainSection
      

module.exports = ChatComponent
