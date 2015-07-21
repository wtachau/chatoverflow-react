React = require("react")

MessageGroupList = React.createFactory require("./MessageGroupList")
PinnedPost = React.createFactory require("./PinnedPost")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ div, img, audio } = React.DOM

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

  componentWillUpdate: (nextProps) ->
    messagesComp = @messagesComponent()
    if messagesComp
      if nextProps.currentRoom != @props.currentRoom
         @isNewThread = true
      else
        @hasNewMessages = nextProps.messages.length != @props.messages.length
        if @hasNewMessages
          @preLoadScrollHeight = messagesComp.scrollHeight

  componentDidUpdate: ->
    messagesComp = @messagesComponent()
    if messagesComp
      if @isNewThread
        @isNewThread = false
        @initialMessagesUpdate messagesComp
      else if @hasNewMessages
        @hasNewMessages = false
        @onOldMessagesReceived messagesComp
      else
        [..., last] = @props.messages
        if last and last.isNewMessage
          @refs.plingsound.getDOMNode().play()
          last.isNewMessage = false
          if (@getScrollPosition messagesComp) < @state.chat.autoScrollWindow
            messagesComp.scrollTop = messagesComp.scrollHeight

  initialMessagesUpdate: (messagesComponent) ->
    @state.chat.isFinishedLoadingMessages = false
    messagesComponent.scrollTop = messagesComponent.scrollHeight

  onOldMessagesReceived: (messagesComponent) ->
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
            if (not @state.chat.isFinishedLoadingMessages or @messagesComponent.scrollHeight)
              img {className: "loading-icon", src: "../../../assets/images/loading.gif"}
            MessageGroupList { messageGroups, shouldUpdateScrollHeight: @shouldUpdateScrollHeight }
          audio {ref: "plingsound", src: "../../../assets/sounds/pling.wav"}

module.exports = MessageList
