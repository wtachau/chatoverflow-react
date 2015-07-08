React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Badge = React.createFactory ReactBootstrap.Badge
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button
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

  badge: (room_id) ->
    if @state.app.unread_mentions[parseInt(room_id)]
      Badge {}, 1
    else
      ""

  render: ->
    ListGroup {className: "sidebar"},
      h1 {className: "categories-header"}, "Languages"
      @props.topics.map ({name, id, rooms}, index) ->
        Link {to: "/topics/#{id}", key: index},
          ListGroupItem {className: "topic-name"}, name
      h1 {className: "categories-header"}, "Rooms Following"
        @props.user.followed_rooms.map ({id}) =>
          Link {to: "/rooms/#{id}"},
            ListGroupItem {className: "topic-name"},
              "room #{id}",
              @badge(id),
              div {className: "exit-x", "data-id": id, onClick: @onCloseRoom}, "x"

module.exports = TopicSidebar
