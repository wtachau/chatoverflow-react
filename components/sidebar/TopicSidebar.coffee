React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Badge = React.createFactory ReactBootstrap.Badge
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button
TopicSearch = React.createFactory require("./TopicSearch")
TopicListItem = React.createFactory require("./TopicListItem")
RoomListItem = React.createFactory require("./RoomListItem")
AppActions = require("../../actions/AppActions")
AppStore = require("../../stores/AppStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ h1, div, span } = React.DOM

TopicSidebar = React.createClass
  displayName: "TopicSidebar"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore

  propTypes:
    topics: React.PropTypes.array.isRequired
    user: React.PropTypes.object.isRequired

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
      h1 {className: "categories-header"}, "Topics Following"
      @props.user.followed_topics.map ({id, name}, index) =>
        TopicListItem {id, name, index, onClose: @onCloseTopic}

      TopicSearch {isFollowingTopic: @props.isFollowingTopic}

      h1 {className: "categories-header"}, "Rooms Following"
      @props.user.followed_rooms.map ({id, topic_id}, index) =>
        RoomListItem {id, topic_id, name, index, onClose: @onCloseRoom, badge: @badge(id)}

module.exports = TopicSidebar
