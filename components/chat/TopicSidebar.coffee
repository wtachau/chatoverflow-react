React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button

{ h1, bsStyle } = React.DOM

TopicSidebar = React.createClass
  displayName: "TopicSidebar"

  propTypes:
    topics: React.PropTypes.array.isRequired
    user: React.PropTypes.object.isRequired

  render: ->
    ListGroup {className: "sidebar"},
      h1 {className: "categories-header"}, "Languages"
      @props.topics.map ({name, id, rooms}, index) ->
        Link {to: "/topics/#{id}", key: index},
          ListGroupItem {className: "topic-name"}, name
      h1 {className: "categories-header"}, "Rooms Following"
        @props.user.followed_rooms.map ({id}) ->
          Link {to: "/rooms/#{id}"},
            ListGroupItem {className: "topic-name"}, "room #{id}"
              Button {bsStyle: "xsmall"}, "X"


module.exports = TopicSidebar
