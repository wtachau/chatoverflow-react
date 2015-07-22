React = require("react")
io = require("socket.io-client")

AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
URLResources = require("../common/URLResources")
FollowResources = require("../common/FollowResources")
Router = require("react-router")
RouteHandler = React.createFactory Router.RouteHandler
RoomList = React.createFactory require("./chat/RoomList")
{ div } = React.DOM

ChatStore = require("../stores/ChatStore")
ChatActions = require("../actions/ChatActions")

TopicComponent = React.createClass
  displayName: "TopicComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  componentWillReceiveProps: (newProps) -> @updateTopicSelected(newProps)
  componentDidMount: -> @updateTopicSelected(@props)

  updateTopicSelected: (props) ->
    setTimeout =>
      unless props.params.topic_id is @state.chat.topicSelected
        ChatActions.setTopicSelected props.params.topic_id


  render: ->
    div {className: "main-section"},
      RouteHandler {socket: @props.socket}
      RoomList
        currentTopic: @getParams().topic_id

module.exports = TopicComponent
