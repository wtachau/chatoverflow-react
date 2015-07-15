React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./sidebar/TopicSidebar")
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
      unless @isFollowingRoom room_id
        AppActions.followRoom room_id, @isFollowingRoom
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
      ChatActions.fetchRecentMessages @getParams().room_id
      if @state.app.unread_mentions[parseInt(@getParams().room_id)]
        AppActions.setReadMentions @getParams().room_id

  componentDidMount: ->
    ChatActions.fetchRecentMessages @getParams().room_id
    AppActions.setReadMentions @getParams().room_id

  componentWillUnmount: ->
    @socket.removeAllListeners "chat message"
    @socket.removeAllListeners "mention"

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

module.exports = RoomComponent
