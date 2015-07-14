React = require("react")
RoomListItem = React.createFactory require("./RoomListItem")
{ h1, div } = React.DOM

module.exports = React.createClass
  displayName: "RoomList"

  propTypes:
    rooms: React.PropTypes.array.isRequired
    onClose: React.PropTypes.func.isRequired
    badge: React.PropTypes.func.isRequired

  render: ->
    div {},
      h1 {className: "categories-header"}, "Rooms Following"
      @props.rooms.map ({id, topic_id}, index) =>
        RoomListItem {id, topic_id, name, index, onClose: @props.onClose, badge: @props.badge(id)}
