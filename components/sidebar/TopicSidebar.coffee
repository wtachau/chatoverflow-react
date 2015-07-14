React = require("react")
ReactBootstrap = require("react-bootstrap")
ListGroup = React.createFactory ReactBootstrap.ListGroup
Badge = React.createFactory ReactBootstrap.Badge
TopicSearch = React.createFactory require("./TopicSearch")
TopicList = React.createFactory require("./TopicList")
TopicListItem = React.createFactory require("./TopicListItem")
RoomList = React.createFactory require("./RoomList")
RoomListItem = React.createFactory require("./RoomListItem")
AppActions = require("../../actions/AppActions")
AppStore = require("../../stores/AppStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ span } = React.DOM

module.exports = React.createClass
  displayName: "TopicSidebar"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore

  propTypes:
    user: React.PropTypes.object.isRequired
    isFollowingRoom: React.PropTypes.func.isRequired
    isFollowingTopic: React.PropTypes.func.isRequired

  onCloseRoom: (e) ->
    room_clicked = e.target.getAttribute("data-id")
    AppActions.followRoom room_clicked, @props.isFollowingRoom
    e.preventDefault()

  onCloseTopic: (e) ->
    topic_clicked = e.target.getAttribute("data-id")
    AppActions.followTopic topic_clicked, @props.isFollowingTopic
    e.preventDefault()

  badge: (room_id) ->
    if @state.app.unread_mentions[parseInt(room_id)]
      Badge {}, 1
    else
      span {}, ""

  render: ->
    ListGroup {className: "sidebar"},
      TopicList
        topics: @props.user.followed_topics
        onClose: @onCloseTopic

      TopicSearch
        isFollowingTopic: @props.isFollowingTopic

      RoomList
        rooms: @props.user.followed_rooms
        onClose: @onCloseRoom
        badge: @badge

