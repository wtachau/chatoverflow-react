React                = require("react")
ReactBootstrap       = require("react-bootstrap")
Router               = require("react-router")
URLResources         = require("../../common/URLResources")
ThreadStore          = require("../../stores/ThreadStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
moment               = require("moment")

ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Row           = React.createFactory ReactBootstrap.Row
Col           = React.createFactory ReactBootstrap.Col
Link          = React.createFactory Router.Link

{ div, ul, li, img } = React.DOM


RoomInfo = React.createClass
  displayName: "RoomInfo"

  propTypes:
    room: React.PropTypes.object.isRequired
    topic: React.PropTypes.number.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ThreadStore

  render: ->
    message = @props.room.messages[0]
    question = if message then message.text else ""
    username = if message then message.username else ""

    date = moment(@props.room.created_at).format("MM/DD/YY")
    time = moment(@props.room.created_at).format("HH:mm")
    timestamp = "asked #{date} at #{time} by #{username}"

    answersTotal = @props.room.messages.length - 1

    roomProperties = if @state.currentRoom is @props.room.id then "highlight-room" else ""
    ListGroupItem {className: "room-info #{roomProperties}"},
      Link {to: "/topics/#{@props.topic}/rooms/#{@props.room.id}"},
        div {className: "answers"},
          div {className: "answer-total"}, answersTotal
        Row {},
          Col {className: "question-info", xs:8},
            if @props.room.topic_title
              div {className: "topic-title"}, @props.room.topic_title
            div {className: "question-header"},
              div {className: "question-title"}, @props.room.title
            div {className: "time-asked"}, timestamp

module.exports = RoomInfo
