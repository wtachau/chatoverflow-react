React                = require("react")
UserStore            = require("../../stores/UserStore")
UserActions          = require("../../actions/UserActions")
ThreadStore          = require("../../stores/ThreadStore")
ThreadActions        = require("../../actions/ThreadActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

MessageGroupList = React.createFactory require("./MessageGroupList")
PinnedPost       = React.createFactory require("./PinnedPost")

{ div, i } = React.DOM

AutoScrollWindow = 160

MessageList = React.createClass
  displayName: "MessageList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      thread: ThreadStore

  propTypes:
    originalPost: React.PropTypes.object.isRequired
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  messagesComponent: ->
    React.findDOMNode this.refs.messages

  componentWillUpdate: (nextProps) ->
    messagesComp = @messagesComponent()
    if messagesComp
      if nextProps.currentRoom isnt @props.currentRoom
         @isNewThread = true
      else
        @hasNewMessages = nextProps.messages.length isnt @props.messages.length
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
          last.isNewMessage = false
          if (@getScrollPosition messagesComp) < AutoScrollWindow
            messagesComp.scrollTop = messagesComp.scrollHeight

  initialMessagesUpdate: (messagesComponent) ->
    @state.thread.isFinishedLoadingMessages = false
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
      ThreadActions.fetchOldMessages @props.currentRoom,
        parseInt(@state.thread.oldestPage) + 1

  createGroups: (rest) ->
  # groups messages together by username
    messageGroups = []
    group = []
    rest.map (message, index) =>
      if index isnt 0 and rest[index-1].user.username isnt message.user.username
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
            if (not @state.thread.isFinishedLoadingMessages or @messagesComponent.scrollHeight)
              i {className: "icon-spinner icon-spin icon-large"}
            MessageGroupList { messageGroups, shouldUpdateScrollHeight: @shouldUpdateScrollHeight }

module.exports = MessageList
