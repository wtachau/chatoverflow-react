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

  render: ->
    [first, rest...] = @props.messages
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            first: first
            currentRoom: @props.currentRoom
            isFollowingRoom: @props.isFollowingRoom
          div {className: "messages", ref: "messages", onScroll: @checkWindowScroll},
            rest.map (message, index) =>
              console.log message
              userColorClass = if message.user.username is @state.app.user.username
                "self-message-bubble"
              else
                "others-message-bubble"
              Message { message, key: index, className: userColorClass }

module.exports = MessageList
