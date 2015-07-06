React = require("react")

Message = React.createFactory require("./Message")
PinnedPost = React.createFactory require("./PinnedPost")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")


{ div, button } = React.DOM

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
    [first, rest...] = @props.messages
    if @props.messages.length is 0
      div {}
    else
      div {},
        button {onClick: @followRoom}, @buttonText()
        PinnedPost { username: first.username, text: first.text, created_at: first.created_at }
        div {className: "messages"},
          rest.map ({username, text, created_at}, index) ->
            oddClass = if index % 2 == 1 then "odd" else ""
            Message { username, text, key: index, className: oddClass, created_at }

module.exports = MessageList
