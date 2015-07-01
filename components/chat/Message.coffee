React = require("react")

ReactBootstrap = require("react-bootstrap")
moment = require("moment")

Row = React.createFactory ReactBootstrap.Row
{ div, p, img, video } = React.DOM

Message = React.createClass
  displayName: "Message"

  propTypes:
    username: React.PropTypes.string.isRequired
    text: React.PropTypes.string.isRequired

  decorateText: (text) ->
    if text.match ///((^https?:\/\/.*\.(?:png|jpg|gif)$)){1}///
      return img {src: text}
    else if text.match ///((^https?:\/\/.*\.(?:gifv)$)){1}///
      return video {src: (text.replace "gifv", "mp4"), type: "video/mp4", preload: "auto", autoPlay: "autoplay", loop: "loop", muted: "muted"}
    else ""

  render: ->
    Row {className: "message-row " + @props.className},
      div {className: "username"}, @props.username
      div {className: "chat-body"},
        div {className: "text"}, @props.text
        @decorateText @props.text
        div {className: "timestamp"}, moment().format("h:mm A")

module.exports = Message
