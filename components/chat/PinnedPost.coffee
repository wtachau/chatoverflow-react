React                = require("react")
Marked               = require("react-marked")
ReactBootstrap       = require("react-bootstrap")
moment               = require("moment")
UserStore            = require("../../stores/UserStore")
UserActions          = require("../../actions/UserActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
FollowResources      = require("../../common/FollowResources")

UserComponent = React.createFactory require("../UserComponent")
Row           = React.createFactory ReactBootstrap.Row
Button        = React.createFactory ReactBootstrap.Button

{ div, button, img, i } = React.DOM

PinnedPost = React.createClass
  displayName: "PinnedPost"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore

  propTypes:
    originalPost: React.PropTypes.object.isRequired
    currentRoom: React.PropTypes.string.isRequired

  followRoom: ->
    UserActions.followRoom @props.currentRoom, @state.user.user

  buttonComponent: ->
    isFollowing = FollowResources.isFollowingRoom @props.currentRoom, @state.user.user
    followText = "Following"
    starClass = "fa-star"
    mainClass = "following"
    unless isFollowing
      followText = "Follow"
      starClass = "fa-star-o"
      mainClass = ""
    div {className: "follow-button #{mainClass}"},
      followText,
      i {className: "fa #{starClass}"}

  render: ->
    timestamp = moment(@props.originalPost.created_at).format("h:mm A")
    Row {className: "pinned-post"},
      div {className: "username"},
        UserComponent {user: @props.originalPost.user}
        div {className: "username-text"},
          @props.originalPost.user.username
      div {className: "chat-body"},
        div {className: "text"}, Marked @props.originalPost.text
        div {onClick: @followRoom}, @buttonComponent()

module.exports = PinnedPost
