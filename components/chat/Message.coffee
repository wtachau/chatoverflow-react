React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")
VoteButton = React.createFactory require("./VoteButton")
Col = React.createFactory ReactBootstrap.Col
Row = React.createFactory ReactBootstrap.Row
{ div, img, video, button } = React.DOM

Message = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired
    votes: React.PropTypes.number.isRequired

  decorateText: (text) ->
    if text.match ///((^https?:\/\/.*\.(?:png|jpg|gif)$)){1}///
      return img {src: text}
    else if text.match ///((^https?:\/\/.*\.(?:gifv)$)){1}///
      return video
        src: (text.replace "gifv", "mp4")
        type: "video/mp4"
        preload: "auto"
        autoPlay: "autoplay"
        loop: "loop"
        muted: "muted"
    else ""

  render: ->
    timestamp = moment(@props.message.created_at).format("h:mm A")
    Row {className: "row-no-margin"},
      Col {xs: 8, className: "col-no-padding"},
        div {className: "bubble message-row #{@props.side} #{@props.bubbleType}"},
          div {className: "chat-body"},
            div {className: "text"}, Marked @props.message.text
            @decorateText @props.message.text
      Col {xs: 2, className: "vote-column col-no-padding"},
        VoteButton {message: @props.message, votes: @props.votes}
      Col {xs: 2, className: "col-no-padding"},
        div {className: "timestamp"}, timestamp

module.exports = Message
