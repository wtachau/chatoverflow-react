React = require("react")

{ div, button } = React.DOM
Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

MessageList = React.createClass
  displayName: "MessageList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore

  propTypes:
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  componentDidUpdate: ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight

  followRoom: ->
    AppActions.followRoom @props.currentRoom, @props.isFollowingRoom

  buttonText: ->
    isFollowing = @props.isFollowingRoom @props.currentRoom
    if isFollowing then 'Unfollow Room' else "Follow Room"

  render: ->
    div {className: "messages"},
      button {onClick: @followRoom}, @buttonText()
      @props.messages.map ({username, text, created_at}, index) =>
        userColorClass = if username is @state.app.user.username then "usercolor" else ""
        Message { username, text, key: index, className: userColorClass, created_at }

module.exports = MessageList
