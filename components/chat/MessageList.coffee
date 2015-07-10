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
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  componentDidUpdate: ->
    component = React.findDOMNode this.refs.messages
    if component
      component.scrollTop = component.scrollHeight

  # If we are receiving new messages, maintain scroll height
  componentWillReceiveProps: (nextProps) ->
    noNewMessages = (nextProps.messages.length is @props.messages.length)
    unless noNewMessages or (@props.messages.length is 0)
      component = React.findDOMNode this
      @shouldUpdateScrollHeight = true
      @oldScrollHeight = component.scrollHeight

  componentDidUpdate: ->
    component = React.findDOMNode this
    if @shouldUpdateScrollHeight
      component.scrollTop = component.scrollHeight - @oldScrollHeight
      @shouldUpdateScrollHeight = false

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
    [first, rest...] = @props.messages
    messageGroupCount = @countMessageGroups rest
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            first: first
            currentRoom: @props.currentRoom
            isFollowingRoom: @props.isFollowingRoom
          div {className: "messages", ref: "messages", onScroll: @checkWindowScroll},
            @renderBubbleType rest, messageGroupCount

module.exports = MessageList
