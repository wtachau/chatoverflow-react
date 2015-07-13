React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
ChatActions = require("../../actions/ChatActions")
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

  upvote: ->
    ChatActions.upvoteMessage @props.message.id, @props.message.room_id

  downvote: ->
    ChatActions.downvoteMessage @props.message.id, @props.message.room_id

  render: ->
    timestamp = moment(@props.message.created_at).format("h:mm A")
    Row {className: "bubble message-row #{@props.side} #{@props.bubbleType}"},
      div {className: "votes"},
        button
          className: "vote-button upvote btn btn-default"
          onClick: @upvote,
          "\u25b2"
        button
          className: "vote-button downvote btn btn-default"
          onClick: @downvote,
          "\u25bc"
        div {className: "vote-total"}, @props.message.vote_total
      div {className: "username"}, @props.message.user.username,
        img {className: "profile-pic", src: @props.message.user.pic_url}
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.message.text
        @decorateText @props.message.text
        div {className: "timestamp"}, timestamp

module.exports = Message
