React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
ChatActions = require("../../actions/ChatActions")
moment = require("moment")

Row = React.createFactory ReactBootstrap.Row
{ div, p, img, video, button, span } = React.DOM

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

  upvote: -> ChatActions.upvoteMessage @props.message.id, @props.message.room_id
  downvote: -> ChatActions.downvoteMessage @props.message.id, @props.message.room_id

  render: ->
    timestamp = moment(@props.message.created_at).format("h:mm A")
    Row {className: "message-row " + @props.message.className},
      div {className: "votes"},
        button {className: "upvote btn btn-default", onClick: @upvote}, "▲"
        button {className: "downvote btn btn-default", onClick: @downvote}, "▼"
        div {className: "vote-total"}, @props.message.vote_total
      div {className: "username"}, @props.message.username
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.message.text
        @decorateText @props.message.text
        div {className: "timestamp"}, timestamp

module.exports = Message
