React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Badge = React.createFactory ReactBootstrap.Badge
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button
TopicSearch = React.createFactory require("./TopicSearch.coffee")
AppActions = require("../../actions/AppActions")
AppStore = require("../../stores/AppStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ h1, div } = React.DOM

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
      ""

  render: ->
    ListGroup {className: "sidebar"},
      h1 {className: "categories-header"}, "Topics Following"
        @state.app.user.followed_topics.map ({id, name}, index) =>
          Link {to: "/topics/#{id}", key: index},
            ListGroupItem {className: "topic-name"},
              name,
              div {className: "exit-x", "data-id": id, onClick: @onCloseTopic}, "x"
      TopicSearch {isFollowingTopic: @props.isFollowingTopic}
      h1 {className: "categories-header"}, "Rooms Following"
        @state.app.user.followed_rooms.map ({id, topic_id}, index) =>
          Link {to: "/topics/#{topic_id}/rooms/#{id}", key: index},
            ListGroupItem {className: "topic-name"},
              "Room #{id}",
              @badge(id),
              div {className: "exit-x", "data-id": id, onClick: @onCloseRoom}, "x"

module.exports = TopicSidebar
