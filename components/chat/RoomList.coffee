React                = require("react")
ReactBootstrap       = require("react-bootstrap")
Router               = require("react-router")
URLResources         = require("../../common/URLResources")
RoomStore            = require("../../stores/RoomStore")
RoomActions          = require("../../actions/RoomActions")
UserActions          = require("../../actions/UserActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

RoomInfo      = React.createFactory require("./RoomInfo")
ListGroup     = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link          = React.createFactory Router.Link
Row           = React.createFactory ReactBootstrap.Row
Col           = React.createFactory ReactBootstrap.Col
TabbedArea    = React.createFactory ReactBootstrap.TabbedArea
TabPane       = React.createFactory ReactBootstrap.TabPane

{ div } = React.DOM

RoomList = React.createClass
  displayName: "RoomList"

  propTypes:
    currentTopic: React.PropTypes.string.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: RoomStore

  componentWillReceiveProps: (nextProps) ->
    unless nextProps.currentTopic is @props.currentTopic
      RoomActions.fetchTopicInfo nextProps.currentTopic

  componentDidMount: ->
    RoomActions.fetchTopicInfo @props.currentTopic

  refreshRoomList: ->
    RoomActions.fetchTopicInfo @props.currentTopic

  render: ->
    div {className: "rooms"},
      if @state.topicInfo
        div {className: "room-list-page"},
          Row {className: "topic-header"},
            Link {to: "/topics/#{@props.currentTopic}"},
              div {className: "current-topic"}, @state.topicInfo.name
          div {className: "rooms-list-container"},
            Row {className: "rooms-list"},
              TabbedArea {defaultActiveKey: 1, onClick: @refreshRoomList},
                TabPane {eventKey: 1, tab: "Most Recent"},
                  @state.topicInfo.rooms_newest.map (room, index) =>
                    RoomInfo { room, topic: @state.topicInfo.id, key: index }
                TabPane {eventKey: 2, tab: "Most Active"},
                  @state.topicInfo.rooms_updated_at.map (room, index) =>
                    RoomInfo { room, topic: @state.topicInfo.id , key: index}

module.exports = RoomList
