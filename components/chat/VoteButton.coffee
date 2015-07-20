React = require("react")
ChatActions = require("../../actions/ChatActions")

{ div, button } = React.DOM

VoteButton = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired

  upvote: ->
    ChatActions.upvoteMessage @props.message.id, @props.message.room_id

  render: ->
    div {className: "votes"},
      button
        className: "vote-button upvote btn"
        onClick: @upvote,
        "\u2605"
      div {className: "vote-total"}, @props.message.vote_total

module.exports = VoteButton
