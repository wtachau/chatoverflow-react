React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")

Row = React.createFactory ReactBootstrap.Row
{ div, img, video, button } = React.DOM

Message = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired

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
    Row {className: "bubble message-row #{@props.side} #{@props.bubbleType}"},
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.message.text
        @decorateText @props.message.text
        div {className: "timestamp"}, timestamp

module.exports = Message
