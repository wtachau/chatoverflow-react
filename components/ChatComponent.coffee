React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./chat/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
AskComponent = React.createFactory require("./AskComponent")
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
    currentTopic: React.PropTypes.string

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  username: ->
    @props.user.username

  pic_url: ->
    @props.user.pic_url

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message",
      ({id, user, room_id, text, created_at}) =>
        if room_id is @props.currentRoom
          newList = @state.chat.messages
          newMessage = {vote_total: 0, user, id, room_id, text, created_at, isNewMessage: true}
          newList.push newMessage
          ChatActions.setMessagesList newList
          @scrollDownMessages()

    @socket.on "mention", ({user_id, username, room_id, text}) =>
      unless @isFollowingRoom room_id
        AppActions.followRoom room_id, @isFollowingRoom
      AppActions.setUnreadMentions room_id

  scrollDownMessages: ->
    component = React.findDOMNode @refs.messageList
    component.scrollTop = component.scrollHeight

  componentDidMount: ->
    ChatActions.fetchTopics()
    AppActions.fetchUsers()
    if @props.currentRoom
      ChatActions.fetchRecentMessages @props.currentRoom

  componentWillReceiveProps: (nextProps) ->
    sameRoom = nextProps.currentRoom is @props.currentRoom
    nullRoom = nextProps.currentRoom is null
    unless sameRoom or nullRoom
      @socket.emit "subscribe",
        {username: @username(), room: nextProps.currentRoom}

      @socket.emit "unsubscribe",
        {username: @username(), room: @props.currentRoom}

      ChatActions.fetchRecentMessages nextProps.currentRoom
      AppActions.setReadMentions @props.currentRoom

  isFollowingRoom: (room_id) ->
    followedRoomIds = @state.app.user.followed_rooms.map ({id}) -> id
    parseInt(room_id) in followedRoomIds

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @socket.emit "chat message",
        user:
          user_id: @props.user.id
          pic_url: @pic_url()
          username: @username()
        room_id: @props.currentRoom
        "text": message.trim()
        mentions: mentions
    e.preventDefault()

  render: ->
    mainSection = if @props.currentTopic
      div {className: "main-section"},
        RoomList {currentTopic: @props.currentTopic}
        if @props.currentRoom
          div {className: "messages-section"},
            MessageList
              messages: @state.chat.messages
              currentRoom: @props.currentRoom
              isFollowingRoom: @isFollowingRoom
              ref: "messageList"
            ChatForm
              submitMessage: @submitMessage
              currentMessage: @state.chat.currentMessage
              users: @state.app.users
    else
      AskComponent {}

    div {className: "chat"},
      TopicSidebar
        topics: @state.chat.topics
        user: @state.app.user
        isFollowingRoom: @isFollowingRoom
      div {className: "chat-panel"},
        mainSection

module.exports = ChatComponent
