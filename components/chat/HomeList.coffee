React = require("react")
ReactBootstrap = require("react-bootstrap")
RoomInfo = React.createFactory require("./RoomInfo")
Row = React.createFactory ReactBootstrap.Row

{ div, h1 } = React.DOM

HomeList = React.createClass
  displayName: "HomeList"

  propTypes:
    roomsSorted: React.PropTypes.object.isRequired

  render: ->
    div {className: "room-list-page"},
      div {className: "rooms-list-container"},
        Row {},
          div {className: "current-topic"}, name
        Row {className: "rooms-list"},
          @props.roomsSorted?.map (room) =>
            RoomInfo { room, topic: room.topic_id }

module.exports = HomeList
