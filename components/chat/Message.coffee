React          = require("react")
Marked         = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment         = require("moment")

VoteButton = React.createFactory require("./VoteButton")
Col        = React.createFactory ReactBootstrap.Col
Row        = React.createFactory ReactBootstrap.Row

{ div, img, video, button } = React.DOM

Message = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired
    votes: React.PropTypes.array.isRequired

  decorateText: (text) ->
    imgMatch = text.match ///((https?:\/\/.*\.(?:png|jpg|gif))){1}///
    videoMatch = text.match ///((https?:\/\/.*\.(?:gifv))){1}///
    if imgMatch
      return img {src: imgMatch[0]}
    else if videoMatch
      return video
        src: (videoMatch[0].replace "gifv", "mp4")
        type: "video/mp4"
        preload: "auto"
        autoPlay: "autoplay"
        loop: "loop"
        muted: "muted"
    else ""

  render: ->
    timestamp = moment(@props.message.created_at).format("h:mm A")
    Row {className: "row-no-margin"},
      div {className: "message-column messages-body"},
        div {className: "bubble message-row #{@props.side} #{@props.bubbleType}"},
          div {className: "chat-body"},
            div {className: "text"}, Marked @props.message.text
            @decorateText @props.message.text
      div {className: "message-column votes"},
        if @props.isFirst
          VoteButton {message: @props.message, votes: @props.votes}
      div {className: "message-column time"},
        if @props.isFirst
          div {className: "timestamp"}, timestamp

module.exports = Message
