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

  render: ->
    ListGroup {className: "side-bar"},
      h1 {className: "categories-header"}, "Categories"
      @props.topics.map ({name, id, rooms}, index) ->
        Link {to: "/topics/#{id}", key: index},
          ListGroupItem {className: "topic-name"}, name

module.exports = TopicSidebar
