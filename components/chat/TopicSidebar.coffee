React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link

{ div, h1 } = React.DOM

TopicSidebar = React.createClass
  displayName: "TopicSidebar"

  propTypes:
    topics: React.PropTypes.array.isRequired
    user: React.PropTypes.object.isRequired

  render: ->
    ListGroup {className: "sidebar"},
      h1 {className: "categories-header"}, "Categories"
      @props.topics.map ({name, id, rooms}, index) ->
        Link {to: "/topics/#{id}", key: index},
          ListGroupItem {className: "topic-name"}, name
      @props.user.followed_rooms.map ({id}) ->
        ListGroupItem {}, "room #{id} is currently being followed"

module.exports = TopicSidebar
