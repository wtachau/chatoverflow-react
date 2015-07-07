React = require("react")

Message = React.createFactory require("./Message")
PinnedPost = React.createFactory require("./PinnedPost")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ div } = React.DOM

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
    component = React.findDOMNode this.refs.messages
    component.scrollTop = component.scrollHeight

  render: ->
    [first, rest...] = @props.messages
    console.log first
    div {},
      unless @props.messages.length is 0
        div {},
          PinnedPost
            username: first.username
            text: first.text
            created_at: first.created_at
            currentRoom: @props.currentRoom
            isFollowingRoom: @props.isFollowingRoom
          div {className: "messages", ref: "messages"},
            rest.map (message, index) =>
              userColorClass = if message.username is @state.app.user.username then "usercolor" else ""
              Message { message, key: index, className: userColorClass }

module.exports = MessageList
