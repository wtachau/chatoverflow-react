React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
{ div } = React.DOM

module.exports = React.createClass
  displayName: "RoomListItem"

  propTypes:
    id: React.PropTypes.number.isRequired
    topic_id: React.PropTypes.number.isRequired
    title: React.PropTypes.string.isRequired
    onClose: React.PropTypes.func.isRequired
    badge: React.PropTypes.element.isRequired

  render: ->
    Link {to: "/topics/#{@props.topic_id}/rooms/#{@props.id}"},
      div {className: "topic-name"},
        div {className: "thread-title"}, @props.title
        div {className: "thread-badge"}, @props.badge
        div {className: "exit-x", "data-id": @props.id, onClick: @props.onClose},
          "x"
