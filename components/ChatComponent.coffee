React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./chat/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
HomeComponent = React.createFactory require("./HomeComponent")
RoomList = React.createFactory require("./chat/RoomList")
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
    currentTopic: React.PropTypes.number.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  username: ->
    @props.user.username

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message",
      ({id, user_id, username, room_id, text, created_at}) =>
        if room_id is @props.currentRoom
          newList = @state.chat.messages
          newList.push {vote_total: 0, id, user_id, room_id, username, text, created_at}
          ChatActions.setMessagesList newList

    @socket.on "mention", ({user_id, username, room_id, text}) =>
      alert "#{username} mentioned you in room #{room_id}: #{text}"
      AppActions.followRoom room_id, @isFollowingRoom
      AppActions.setUnreadMentions room_id

  componentDidMount: ->
    ChatActions.fetchTopics()
    AppActions.fetchUsers()
    if @props.currentRoom
      ChatActions.fetchRoomHistory @props.currentRoom

  componentWillReceiveProps: (nextProps) ->
    sameRoom = nextProps.currentRoom is @props.currentRoom
    nullRoom = nextProps.currentRoom is null
    unless sameRoom or nullRoom
      @socket.emit "subscribe",
        {username: @username(), room: nextProps.currentRoom}
      @socket.emit "unsubscribe",
        {username: @username(), room: @props.currentRoom}
      ChatActions.fetchRoomHistory nextProps.currentRoom
      AppActions.setReadMentions @props.currentRoom, false

  isFollowingRoom: (room_id) ->
    followedRoomIds = @state.app.user.followed_rooms.map ({id}) -> id
    parseInt(room_id) in followedRoomIds

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @socket.emit "chat message",
       user_id: @props.user.id
       username: @username()
       room_id: @props.currentRoom
       "text": message.trim()
       mentions: mentions
    e.preventDefault()

  render: ->
    mainSection = if @props.currentRoom
      div {},
        MessageList
          messages: @state.chat.messages
          currentRoom: @props.currentRoom
          isFollowingRoom: @isFollowingRoom
        ChatForm
          submitMessage: @submitMessage
          currentMessage: @state.chat.currentMessage
          users: @state.app.users
    else if @props.currentTopic
      RoomList {currentTopic: @props.currentTopic}
    else
      HomeComponent {}

    div {className: "chat"},
      TopicSidebar
        topics: @state.chat.topics
        user: @state.app.user
        isFollowingRoom: @isFollowingRoom
      mainSection

module.exports = ChatComponent
