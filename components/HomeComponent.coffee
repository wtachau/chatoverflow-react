React                = require("react")
ReactBootstrap       = require("react-bootstrap")
Router               = require("react-router")
RoomStore            = require("../stores/RoomStore")
RoomActions          = require("../actions/RoomActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
CompareDateResources = require("../common/CompareDateResources")

HomeList   = React.createFactory require("./chat/HomeList")
Link       = React.createFactory Router.Link
TabbedArea = React.createFactory ReactBootstrap.TabbedArea
TabPane    = React.createFactory ReactBootstrap.TabPane

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
    roomsSortByCreatedAt = @state.followedTopicsRooms.slice(0)
    roomsSortByNewestMessage = @state.followedTopicsRooms.slice(0)
    roomsSortByCreatedAt.sort CompareDateResources.compareDateCreatedAt
    roomsSortByNewestMessage.sort CompareDateResources.compareLatestMessage
    div {className: "rooms", id: "news-feed"},
      div {className: "current-topic topic-header"},
        Link to: "ask",
          div {className: "home-header"}, ">> ask a question"
      TabbedArea {eventKey: 1, defaultActiveKey: 1},
        TabPane {eventKey: 1, tab: "Most Recent"},
          HomeList {roomsSorted: roomsSortByCreatedAt}
        TabPane {eventKey: 2, tab: "Most Active"},
          HomeList {roomsSorted: roomsSortByNewestMessage}
        
module.exports = HomeComponent
