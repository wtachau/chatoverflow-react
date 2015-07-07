React = require("react")

ReactBootstrap = require("react-bootstrap")

Router = require("react-router")
URLResources = require("../../common/URLResources")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col

{ div, h1 } = React.DOM

RoomList = React.createClass
  displayName: "RoomList"

  propTypes:
    currentTopic: React.PropTypes.number.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  componentWillReceiveProps: (nextProps) ->
    unless nextProps.currentTopic is @props.currentTopic
      ChatActions.fetchTopicInfo nextProps.currentTopic

  componentWillMount: ->
    ChatActions.fetchTopicInfo @props.currentTopic

  render: ->
    div {className: "rooms"},
      if @state.topicInfo
        Col md: 8, mdOffset: 2,
          Row {},
            h1 {className: "current-topic"}, @state.topicInfo.name
          Row {},
            @state.topicInfo.rooms.map ({id}) ->
              Link {to: "/rooms/#{id}"},
                ListGroupItem {className: "topic-name"}, "Room #{id}"


module.exports = RoomList
