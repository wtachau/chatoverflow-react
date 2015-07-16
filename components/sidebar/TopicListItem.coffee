React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
{ div } = React.DOM

module.exports = React.createClass
  displayName: "TopicListItem"

  propTypes:
    id: React.PropTypes.number.isRequired
    name: React.PropTypes.string.isRequired
    index: React.PropTypes.number.isRequired
    onClose: React.PropTypes.func.isRequired

  render: ->
    Link {to: "/topics/#{@props.id}", key: @props.index},
      ListGroupItem {className: "topic-name"},
        @props.name,
        div {className: "exit-x", "data-id": @props.id, onClick: @props.onClose},
          "x"
