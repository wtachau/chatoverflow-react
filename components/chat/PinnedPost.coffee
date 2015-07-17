React = require("react")
Marked = require("react-marked")
ReactBootstrap = require("react-bootstrap")
moment = require("moment")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
FollowResources = require("../../common/FollowResources")
UserComponent = React.createFactory require("../UserComponent")

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
    AppActions.followRoom @props.currentRoom, @state.app.user

  buttonText: ->
    isFollowing = FollowResources.isFollowingRoom @props.currentRoom, @state.app.user
    if isFollowing then 'Unfollow Thread' else "Follow Thread"

  render: ->
    timestamp = moment(@props.originalPost.created_at).format("h:mm A")
    Row {className: "pinned-post"},
      div {className: "username"}, @props.originalPost.user.username,
        UserComponent {user: @props.originalPost.user}
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.originalPost.text
        div {className: "timestamp"}, timestamp
        Button {onClick: @followRoom}, @buttonText()

module.exports = PinnedPost
