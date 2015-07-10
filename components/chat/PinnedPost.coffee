React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

Row = React.createFactory ReactBootstrap.Row
Button = React.createFactory ReactBootstrap.Button
{ div, button, img } = React.DOM

PinnedPost = React.createClass
  displayName: "PinnedPost"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore

  propTypes:
    originalPost: React.PropTypes.object.isRequired
    currentRoom: React.PropTypes.string.isRequired

  followRoom: ->
    AppActions.followRoom @props.currentRoom, @props.isFollowingRoom

  buttonText: ->
    isFollowing = @props.isFollowingRoom @props.currentRoom
    if isFollowing then 'Unfollow Room' else "Follow Room"

  render: ->
    timestamp = moment(@props.originalPost.created_at).format("h:mm A")
    Row {className: "pinned-post"},
      div {className: "username"}, @props.originalPost.user.username,
        img {className: "profile-pic", src: @props.originalPost.user.pic_url}
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.originalPost.text
        div {className: "timestamp"}, timestamp
        Button {onClick: @followRoom}, @buttonText()

module.exports = PinnedPost
