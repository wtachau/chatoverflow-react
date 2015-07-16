React = require("react")

Message = React.createFactory require("./Message")
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
    @componentMounted = true

  componentWillUpdate: (nextProps) ->
    messagesComp = @messagesComponent()
    if messagesComp
      @recievedOldMessages = nextProps.messages.length != @props.messages.length
      if @recievedOldMessages
        @preLoadScrollHeight = messagesComp.scrollHeight

  componentDidUpdate: ->
    messagesComp = @messagesComponent()
    if messagesComp
      if @componentMounted
        @componentMounted = false
        @initialMessagesUpdate(messagesComp)
      else if @recievedOldMessages
        @recievedOldMessages = false
        @onOldMessagesRecieved(messagesComp)
      else
        [..., last] = @props.messages
        if last and last.isNewMessage
          last.isNewMessage = false
          if @getScrollPosition(messagesComp) < 160
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

  countMessageGroups: (rest) ->
    # Groups messages together by username
    # Number of messages in groups end up in messageGroupCount
    messageGroupCount = []
    count = 0
    rest.map (message, index) =>
      if index is 0
        count = 1
      else if index != 0 and rest[index-1].user.username != message.user.username
        messageGroupCount.push count
        count = 1
      else
        count += 1
    messageGroupCount.push count
    messageGroupCount

  selectBubbleType: (count, isFirst) ->
    bubbleType =  if count is 1 and isFirst
                    "single-bubble"
                  else if !(count < 1) and isFirst
                    "top-bubble"
                  else if count is 1 and not isFirst
                    "bottom-bubble"
                  else
                    "middle-bubble"
    bubbleType

  renderBubbleType: (rest, messageGroupCount) ->
    groupIndex = 0
    isFirst = true
    rest.map (message, index) =>
      if message.user.username is @state.app.user.username
        side = "right"
        bubbleType = @selectBubbleType messageGroupCount[groupIndex], isFirst
      else
        side = "left"
        bubbleType = @selectBubbleType messageGroupCount[groupIndex], isFirst
      isFirst = false
      # decrements number of messages left in group there are
      messageGroupCount[groupIndex]--
      # iterates forward to the next group of messages
      if messageGroupCount[groupIndex] is 0
        groupIndex++
        isFirst = true
      Message { message, key: index, bubbleType, side }

  render: ->
    # First and rest are now invalid
    [first, rest...] = @props.messages
    messageGroupCount = @countMessageGroups rest
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            originalPost: @props.originalPost
            currentRoom: @props.currentRoom
            isFollowingRoom: @props.isFollowingRoom
          div {className: "messages", ref: "messages", onScroll: @checkWindowScroll},
            @renderBubbleType rest, messageGroupCount

module.exports = MessageList
