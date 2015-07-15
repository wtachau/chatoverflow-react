React = require("react")
ChatActions = require("../../actions/ChatActions")

{ div, button } = React.DOM

VoteButton = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired

  upvote: ->
    ChatActions.upvoteMessage @props.message.id, @props.message.room_id

  downvote: ->
    ChatActions.downvoteMessage @props.message.id, @props.message.room_id

  render: ->
    div {className: "votes"},
      button
        className: "vote-button upvote btn"
        onClick: @upvote,
        "\u25b2"
      div {}, @props.message.vote_total
      button
        className: "vote-button downvote btn"
        onClick: @downvote,
        "\u25bc"

module.exports = VoteButton
