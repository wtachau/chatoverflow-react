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

  buttonComponent: ->
    isFollowing = FollowResources.isFollowingRoom @props.currentRoom, @state.app.user
    followText = "Unfollow"
    followImgSrc = "../../../assets/images/check.png"
    unless isFollowing
      followText = "Follow"
      followImgSrc = "../../../assets/images/plus.png"
    div {className: "follow-button"},
      img {src: followImgSrc}
      div {}, followText

  render: ->
    timestamp = moment(@props.originalPost.created_at).format("h:mm A")
    Row {className: "pinned-post"},
      div {className: "username"},
        for user in @state.app.users
          if user.username is @props.originalPost.user.username
            UserComponent {user}
        div {className: "username-text"},
          @props.originalPost.user.username
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.originalPost.text
        div {onClick: @followRoom}, @buttonComponent()

module.exports = PinnedPost
