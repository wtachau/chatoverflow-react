React = require("react")

MessageGroupList = React.createFactory require("./MessageGroupList")
PinnedPost = React.createFactory require("./PinnedPost")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ div } = React.DOM

MessageList = React.createClass
  displayName: "MessageList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  propTypes:
    originalPost: React.PropTypes.object.isRequired
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  messagesComponent: ->
    React.findDOMNode this.refs.messages

  componentDidMount: ->
    @hasJustMounted = true

  componentWillUpdate: (nextProps) ->
    messagesComp = @messagesComponent()
    if messagesComp
      @recievedOldMessages = nextProps.messages.length != @props.messages.length
      if @recievedOldMessages
        @preLoadScrollHeight = messagesComp.scrollHeight

  componentDidUpdate: ->
    messagesComp = @messagesComponent()
    if messagesComp
      if @hasJustMounted
        @hasJustMounted = false
        @initialMessagesUpdate messagesComp
      else if @recievedOldMessages
        @recievedOldMessages = false
        @onOldMessagesRecieved messagesComp
      else
        [..., last] = @props.messages
        if last and last.isNewMessage
          last.isNewMessage = false
          if (@getScrollPosition messagesComp) < @state.chat.autoScrollWindow
            messagesComp.scrollTop = messagesComp.scrollHeight

  initialMessagesUpdate: (messagesComponent) ->
    messagesComponent.scrollTop = messagesComponent.scrollHeight

  onOldMessagesRecieved: (messagesComponent) ->
    messagesComponent.scrollTop = messagesComponent.scrollHeight - 
      @preLoadScrollHeight

  getScrollPosition: (messagesComponent) ->
    messagesComponent.scrollHeight - messagesComponent.scrollTop -
      messagesComponent.offsetHeight

  checkWindowScroll: (e) ->
    target = event.target
    scrollTop = target.scrollTop
    if scrollTop is 0
      ChatActions.fetchOldMessages @props.currentRoom,
        parseInt(@state.chat.oldestPage) + 1

  createGroups: (rest) ->
    # groups messages together by username
    messageGroups = []
    group = []
    rest.map (message, index) =>
      if index != 0 and rest[index-1].user.username != message.user.username
        messageGroups.push group
        group = []
      group.push message
    unless group.length is 0
      messageGroups.push group
    messageGroups

  render: ->
    messageGroups = @createGroups @props.messages
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            originalPost: @props.originalPost
            currentRoom: @props.currentRoom
          div {className: "messages", ref: "messages", onScroll: @checkWindowScroll},
            MessageGroupList { messageGroups }

module.exports = MessageList
