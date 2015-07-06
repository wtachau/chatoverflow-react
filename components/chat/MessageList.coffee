React = require("react")

Message = React.createFactory require("./Message")
PinnedPost = React.createFactory require("./PinnedPost")

{ div } = React.DOM

MessageList = React.createClass
  displayName: "MessageList"

  propTypes:
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  componentDidUpdate: ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight

  render: ->
    [first, rest...] = @props.messages
    if @props.messages.length is 0
      div {}
    else
      div {},
        PinnedPost { username: first.username, text: first.text, created_at: first.created_at, currentRoom: @props.currentRoom, isFollowingRoom: @props.isFollowingRoom}
        div {className: "messages"},
          rest.map ({username, text, created_at}, index) ->
            oddClass = if index % 2 == 1 then "odd" else ""
            Message { username, text, key: index, className: oddClass, created_at }

module.exports = MessageList
