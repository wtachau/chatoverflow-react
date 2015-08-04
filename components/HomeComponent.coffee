React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
Link = React.createFactory Router.Link
RoomStore = require("../stores/RoomStore")
RoomActions = require("../actions/RoomActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
HomeList = React.createFactory require("./chat/HomeList")
TabbedArea = React.createFactory ReactBootstrap.TabbedArea
TabPane = React.createFactory ReactBootstrap.TabPane
Comparators = require("../common/Comparators")
{ div, h1 } = React.DOM

HomeComponent = React.createClass
  displayName: "HomeComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: RoomStore

  componentDidMount: ->
    setTimeout =>
      RoomActions.fetchFollowedTopics()
      RoomActions.setTopicSelected null

  render: ->
    roomsByCreatedAt = @state.followedTopicsRooms.slice(0)
    roomsByNewestMessage = @state.followedTopicsRooms.slice(0)
    roomsByCreatedAt.sort Comparators.byCreateDate
    roomsByNewestMessage.sort Comparators.byLatestMessage
    div {className: "rooms", id: "news-feed"},
      div {className: "current-topic topic-header"},
        Link to: "ask",
          div {className: "home-header"}, ">> ask a question"
      TabbedArea {eventKey: 1, defaultActiveKey: 1},
        TabPane {eventKey: 1, tab: "Most Recent"},
          HomeList {roomsSorted: roomsByCreatedAt}
        TabPane {eventKey: 2, tab: "Most Active"},
          HomeList {roomsSorted: roomsByNewestMessage}

module.exports = HomeComponent
