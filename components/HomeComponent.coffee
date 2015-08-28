$                    = require("jquery")
Comparators          = require("../common/Comparators")
React                = require("react")
ReactBootstrap       = require("react-bootstrap")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
RoomActions          = require("../actions/RoomActions")
RoomStore            = require("../stores/RoomStore")
Router               = require("react-router")

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

  slideSidebarRight: ->
    $(".home").removeClass("ask-position-left").addClass("ask-position-right")
    $(".sidebar").removeClass("position-left").addClass("position-right")

  render: ->
    roomsByCreatedAt = @state.followedTopicsRooms.slice(0)
    roomsByNewestMessage = @state.followedTopicsRooms.slice(0)
    roomsByCreatedAt.sort Comparators.byCreateDate
    roomsByNewestMessage.sort Comparators.byLatestMessage
    div {className: "rooms", id: "news-feed"},
      div {className: "current-topic topic-header"},
        div {className: "home-header", onClick: @slideSidebarRight}, "Ask a question"
      TabbedArea {eventKey: 1, defaultActiveKey: 1},
        TabPane {eventKey: 1, tab: "Most Recent"},
          HomeList {roomsSorted: roomsByCreatedAt}
        TabPane {eventKey: 2, tab: "Most Active"},
          HomeList {roomsSorted: roomsByNewestMessage}

module.exports = HomeComponent
