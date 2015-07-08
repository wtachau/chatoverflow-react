React = require("react")

{ div, button } = React.DOM
Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

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

  followRoom: ->
    AppActions.followRoom @props.currentRoom, @props.isFollowingRoom

  buttonText: ->
    isFollowing = @props.isFollowingRoom @props.currentRoom
    if isFollowing then 'Unfollow Room' else "Follow Room"

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
    div {className: "messages", onScroll: @checkWindowScroll},
      button {onClick: @followRoom}, @buttonText()
      @props.messages.map (message, index) =>
        userColorClass = if message.username is @state.app.user.username
          "usercolor"
        else
          ""
        Message { message, key: index, className: userColorClass }

module.exports = MessageList
