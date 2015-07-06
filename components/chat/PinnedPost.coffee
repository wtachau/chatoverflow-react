React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")

Row = React.createFactory ReactBootstrap.Row
{ div, p, img, video } = React.DOM

PinnedPost = React.createClass
  displayName: "PinnedPost"

  propTypes:
    username: React.PropTypes.string.isRequired
    text: React.PropTypes.string.isRequired
    created_at: React.PropTypes.string.isRequired

  render: ->
    timestamp = moment(@props.created_at).format("h:mm A")
    Row {className: "pinnedPost"},
      div {className: "username"}, "@props.username"
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.text
        div {className: "timestamp"}, timestamp

module.exports = PinnedPost
