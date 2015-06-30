React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link

{ div } = React.DOM

TopicSidebar = React.createClass
  displayName: "TopicSidebar"

  propTypes:
    topics: React.PropTypes.array.isRequired

  render: ->
    ListGroup {className: "side-bar"},
      @props.topics.map ({name, id, rooms}, index) ->
        div {className:"topic-name", key: index}, name,
          rooms.map ({id}, index) ->
            Link {to: "/rooms/#{id}", key: index},
              ListGroupItem {}, "room #{id}"

module.exports = TopicSidebar
