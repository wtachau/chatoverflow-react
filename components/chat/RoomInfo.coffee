React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
URLResources = require("../../common/URLResources")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Link = React.createFactory Router.Link
{ div, ul, li } = React.DOM
moment = require("moment")

RoomInfo = React.createClass
  displayName: "RoomInfo"

  propTypes:
    room: React.PropTypes.object.isRequired
    topic: React.PropTypes.string.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  render: ->
    message = @props.room.messages[0]
    question = if message then message.text else ""
    username = if message then message.username else ""

    date = moment(@props.room.created_at).format("MM/DD/YY")
    time = moment(@props.room.created_at).format("HH:mm")
    timestamp = "asked #{date} at #{time} by #{username}"

    answersTotal = @props.room.messages.length - 1

    # By using the two slices, the original questions won't be in the list
    recentAnswers = @props.room.messages.slice(-4).slice(1)

    ListGroupItem {className: "room-info"},
      div {className: "answers"},
        div {className: "answer-total"}, answersTotal
        div {className: "answer-text"},
          if answersTotal is 1 then "answer" else "answers"
      Row {},
        Col {className: "question-info", xs:8},
          div {className: "question-header"},
            Link {to: "/topics/#{@props.topic}/rooms/#{@props.room.id}"},
              div {className: "question-title"}, @props.room.title
            div {className: "time-asked"}, timestamp
          div {className: "question-text"}, question
          div {className: "recent-answers"},
            "Recent Answers:"
            ul {className: "recent-answers-list"},
              recentAnswers.map ({username, text}) ->
                li {className: "recent-answer"}, "#{username} answered: #{text}"

module.exports = RoomInfo
