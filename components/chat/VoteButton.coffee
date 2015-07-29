React         = require("react")
ThreadActions = require("../../actions/ThreadActions")
UserActions   = require("../../actions/UserActions")

{ div, button } = React.DOM

VoteButton = React.createClass
  displayName: "Message"

  propTypes:
    message: React.PropTypes.object.isRequired
    votes: React.PropTypes.array.isRequired

  vote: ->
    ThreadActions.starMessage @props.message.id, @props.message.room_id
    if @color.index is -1
      UserActions.pushUserVote {message_id: @props.message.id}
    else
      UserActions.removeUserVote @color.index
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
