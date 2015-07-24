React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
Link = React.createFactory Router.Link
ChatStore = require("../stores/ChatStore")
ChatActions = require("../actions/ChatActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
HomeList = React.createFactory require("./chat/HomeList")
TabbedArea = React.createFactory ReactBootstrap.TabbedArea
TabPane = React.createFactory ReactBootstrap.TabPane
CompareDateResources = require("../common/CompareDateResources")
{ div, h1 } = React.DOM

HomeComponent = React.createClass
  displayName: "HomeComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  componentDidMount: ->
    setTimeout =>
      ChatActions.fetchFollowedTopics()
      ChatActions.setTopicSelected null

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
