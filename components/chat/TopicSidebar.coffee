React = require "react"
ReactBootstrap = require "react-bootstrap"
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem

TopicSidebar = React.createClass
  render: ->
    ListGroup {className: "side-bar"},
      ListGroupItem {}, "Ruby"
      ListGroupItem {}, "Java"
      ListGroupItem {}, "C++"
      ListGroupItem {}, "Scala"
      ListGroupItem {}, "Android"
      ListGroupItem {}, "iOS"

module.exports = TopicSidebar
