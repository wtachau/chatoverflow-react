React = require("react")

ReactBootstrap = require("react-bootstrap")

Router = require("react-router")
URLResources = require("../../common/URLResources")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
{ div, h1 } = React.DOM

RoomList = React.createClass
  propTypes:
    currentTopic: React.PropTypes.number.isRequired

  getInitialState: ->
    topic: null

  componentWillMount: ->
    console.log "In componentWillMount"
    URLResources.readFromAPI "/topics/#{@props.currentTopic}", (response)=>
      @setState topic: response

  render: ->
    console.log "In render room list with currentTopic = ", @props.currentTopic
    div {className: "rooms"},
      if @state.topic
        Row {},
          Col xs: 8,
            h1 {className: "current-topic"}, @state.topic.name
        Row {},
          Col xs: 8,
            @state.topic.rooms.map ({id}) ->
              Link {to: "/rooms/#{id}"},
                ListGroupItem {className: "topic-name"}, "Room #{id}"


module.exports = RoomList
