React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
URLResources = require("../../common/URLResources")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
{ div } = React.DOM
moment = require("moment")

RoomInfo = React.createClass
  displayName: "RoomInfo"

  propTypes:
    room: React.PropTypes.object.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  question: ->
    if @props.room.messages.length > 0
      @props.room.messages[0].text
    else
      "No question here!"

  timestamp: ->
    date = moment(@props.room.created_at).format("MM/DD/YY")
    time = moment(@props.room.created_at).format("HH:mm")
    "asked #{date} at #{time} by #{@username()}"

  username: ->
    if @props.room.messages.length > 0
      @props.room.messages[0].username
    else
      ""

  answersTotal: -> @props.room.messages.length - 1

  render: ->
    ListGroupItem {className: "room-info"},
      div {className: "answers"},
        div {className: "answer-total"}, @answersTotal()
        div {className: "answer-text"},
          if @answersTotal() is 1 then "answer" else "answers"
      Link {to: "/rooms/#{@props.room.id}"},
        div {className: "question"}, @question()
      div {className: "time-asked"}, @timestamp()

module.exports = RoomInfo
