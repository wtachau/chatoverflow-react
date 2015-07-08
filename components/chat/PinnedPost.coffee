React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

Row = React.createFactory ReactBootstrap.Row
{ div, button, img } = React.DOM

PinnedPost = React.createClass
  displayName: "PinnedPost"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore

  propTypes:
    first: React.PropTypes.object.isRequired
    currentRoom: React.PropTypes.string.isRequired

  followRoom: ->
    AppActions.followRoom @props.currentRoom, @props.isFollowingRoom

  buttonText: ->
    isFollowing = @props.isFollowingRoom @props.currentRoom
    if isFollowing then 'Unfollow Room' else "Follow Room"

  render: ->
    timestamp = moment(@props.first.created_at).format("h:mm A")
    Row {className: "pinnedPost"},
      div {className: "username"}, @props.first.username,
        img {className: "profile-pic", src: @props.first.user.pic_url}
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.first.text
        div {className: "timestamp"}, timestamp
        button {onClick: @followRoom}, @buttonText()

module.exports = PinnedPost
