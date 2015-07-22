React = require("react")
ChatActions = require("../../actions/ChatActions")
AppActions = require("../../actions/AppActions")

{ div, button } = React.DOM

VoteButton = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired
    votes: React.PropTypes.array.isRequired

  vote: ->
    ChatActions.starMessage @props.message.id, @props.message.room_id
    if @color.index is -1
      AppActions.pushUserVote {message_id: @props.message.id}
    else
      AppActions.removeUserVote @color.index
      @color.color = {color: "", index: -1}

  buttonColor: ->
    for votes, index in @props.votes
      return {color: "gold", index: index} if votes.message_id is @props.message.id
    {color: "", index: -1}

  render: ->
    @color = if @props.votes then @buttonColor() else ""
    displayClass = if @props.message.vote_total > 0 then "display" else ""
    div {className: "votes"},
      button
        className: "vote-button upvote btn #{@color.color} #{displayClass}"
        onClick: @vote,
        "\u2605"
      if @props.message.vote_total > 0
        div {className: "vote-total"}, @props.message.vote_total

module.exports = VoteButton
