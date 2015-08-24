React                = require("react")
ReactBootstrap       = require("react-bootstrap")
UserActions          = require("../../actions/UserActions")
UserStore            = require("../../stores/UserStore")
MentionStore         = require("../../stores/MentionStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

TopicSearch   = React.createFactory require("./TopicSearch")
TopicList     = React.createFactory require("./TopicList")
TopicListItem = React.createFactory require("./TopicListItem")
RoomList      = React.createFactory require("./RoomList")
RoomListItem  = React.createFactory require("./RoomListItem")
ListGroup     = React.createFactory ReactBootstrap.ListGroup
Badge         = React.createFactory ReactBootstrap.Badge

{ span, div, img, h3 } = React.DOM

module.exports = React.createClass
  displayName: "TopicSidebar"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      mention: MentionStore

  propTypes:
    user: React.PropTypes.object.isRequired

  onCloseRoom: (e) ->
    room_clicked = e.target.getAttribute("data-id")
    UserActions.followRoom room_clicked, @props.user
    e.preventDefault()

  onCloseTopic: (e) ->
    topic_clicked = e.target.getAttribute("data-id")
    UserActions.followTopic topic_clicked, @props.user
    e.preventDefault()

  badge: (room_id) ->
    if @state.mention.unread[parseInt(room_id)]
      Badge {}, 1
    else
      span {}, ""

  render: ->
    ListGroup {className: "sidebar"},
      div {className: "logo-div"},
        img {src: "../../assets/images/icon_placeholder.png", className: "logo"}
        h3 {className: "categories-header"}, "chatSignal"
      TopicList
        topics: @props.user.followed_topics
        onClose: @onCloseTopic

      TopicSearch
        user: @props.user

      RoomList
        rooms: @props.user.followed_rooms
        onClose: @onCloseRoom
        badge: @badge

