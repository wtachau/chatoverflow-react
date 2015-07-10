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
RoomInfo = React.createFactory require("./RoomInfo")

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
TabbedArea = React.createFactory ReactBootstrap.TabbedArea
TabPane = React.createFactory ReactBootstrap.TabPane

{ div, h1 } = React.DOM

RoomList = React.createClass
  displayName: "RoomList"

  propTypes:
    currentTopic: React.PropTypes.string.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  componentWillReceiveProps: (nextProps) ->
    unless nextProps.currentTopic is @props.currentTopic
      ChatActions.fetchTopicInfo nextProps.currentTopic

  componentWillMount: ->
    ChatActions.fetchTopicInfo @props.currentTopic

  refreshRoomList: ->
    ChatActions.fetchTopicInfo @props.currentTopic

  render: ->
    div {className: "rooms"},
      if @state.topicInfo
        div {className: "room-list-page"},
          Row {className: "topic-header"},
            h1 {className: "current-topic"}, @state.topicInfo.name
          Row {className: "rooms-list"},
            TabbedArea {defaultActiveKey: 1, onClick: @refreshRoomList},
              TabPane {eventKey: 1, tab: "Most Recent"},
                @state.topicInfo.rooms_newest.map (room) => RoomInfo { room, topic: @state.topicInfo.id }
              TabPane {eventKey: 2, tab: "Most Active"},
                @state.topicInfo.rooms_updated_at.map (room) => RoomInfo { room, topic: @state.topicInfo.id }


module.exports = RoomList
