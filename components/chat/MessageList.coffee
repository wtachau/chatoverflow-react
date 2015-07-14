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

  # If we are receiving new messages, maintain scroll height
  componentWillUpdate: (nextProps) ->
    noNewMessages = (nextProps.messages.length is @props.messages.length)
    unless noNewMessages or (@props.messages.length is 0)
      @shouldUpdateScrollHeight = true
      @oldScrollHeight = @messagesComponent().scrollHeight

  componentDidUpdate: ->
    if @messagesComponent()
      # If we are scrolled to the bottom already and there's
      # a new message, then scroll down to see it
      autoscrollWindow = 160
      scrollPosition = @messagesComponent().scrollHeight -
                        @messagesComponent().scrollTop -
                        @messagesComponent().offsetHeight
      [..., last] = @props.messages
      if last.isNewMessage
        if scrollPosition < autoscrollWindow
          @messagesComponent().scrollTop = @messagesComponent().scrollHeight
        last.isNewMessage = false

      # If older messages got loaded above current ones,
      # scroll down so current ones are still in sight
      if @shouldUpdateScrollHeight
        @messagesComponent().scrollTop = @messagesComponent().scrollHeight - @oldScrollHeight
        @shouldUpdateScrollHeight = false

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
    [first, rest...] = @props.messages
    messageGroups = @createGroups rest
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            originalPost: @props.originalPost
            currentRoom: @props.currentRoom
            isFollowingRoom: @props.isFollowingRoom
          div {className: "messages", ref: "messages", onScroll: @checkWindowScroll},
            MessageGroupList { messageGroups }

module.exports = MessageList
