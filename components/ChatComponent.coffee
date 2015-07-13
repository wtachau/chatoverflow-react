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
Router = require("react-router")

ChatComponent = React.createClass
  displayName: "ChatComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  username: ->
    @state.app.user.username

  pic_url: ->
    @state.app.user.pic_url

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message",
      ({id, user, room_id, text, created_at}) =>
        if room_id is @getParams().room_id
          newList = @state.chat.messages
          newList.push {vote_total: 0, user, id, room_id, text, created_at, isNewMessage: true}
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
    if @getParams().room_id
      ChatActions.fetchRecentMessages @getParams().room_id

  componentWillReceiveProps: (nextProps) ->
    sameRoom = nextProps.currentRoom is @getParams().room_id
    nullRoom = nextProps.currentRoom is null
    unless sameRoom or nullRoom
      @socket.emit "subscribe",
        {username: @username(), room: nextProps.currentRoom}

      @socket.emit "unsubscribe",
        {username: @username(), room: @getParams().room_id}

      ChatActions.fetchRecentMessages nextProps.currentRoom
      AppActions.setReadMentions @getParams().room_id

  isFollowingRoom: (room_id) ->
    followedRoomIds = @state.app.user.followed_rooms.map ({id}) -> id
    parseInt(room_id) in followedRoomIds

  isFollowingTopic: (topic_id) ->
    followedTopicIds = @state.app.user.followed_topics.map ({id}) -> id
    parseInt(topic_id) in followedTopicIds

  submitMessage: (e, message, mentions) ->
    unless message is ""
      @socket.emit "chat message",
        user:
          user_id: @state.app.user.id
          pic_url: @pic_url()
          username: @username()
        room_id: @getParams().room_id
        "text": message.trim()
        mentions: mentions
    e.preventDefault()

  render: ->
    console.log @getParams()
    mainSection = if @getParams().topic_id
      div {className: "main-section"},
        RoomList
          currentTopic: @getParams().topic_id
          isFollowingTopic: @isFollowingTopic
        if @getParams().room_id
          div {className: "messages-section"},
            MessageList
              originalPost: @state.chat.originalPost
              messages: @state.chat.messages
              currentRoom: @getParams().room_id
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
        isFollowingTopic: @isFollowingTopic
      div {className: "chat-panel"},
        mainSection

module.exports = ChatComponent
