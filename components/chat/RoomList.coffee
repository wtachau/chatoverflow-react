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
    rooms: []

  componentWillMount: ->
    URLResources.readFromAPI "/topics", (response)=>
      @setState rooms: response

  render: ->
    div {className: "rooms"},
      Row {},
        Col xs: 8,
          h1 {className: "current-topic"}, @props.currentTopic 
      Row {},
        Col xs: 8,
          @state.rooms.map ({name, id, rooms}) ->
        div {}, 
          @state.rooms.map ({id}) ->
            Link {to: "/rooms/#{id}"},
              ListGroupItem {className: "topic-name"}, "Room #{id}"


module.exports = RoomList