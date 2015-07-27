React = require("react")
io = require("socket.io-client")

UserStore = require("../stores/UserStore")
UserActions = require("../actions/UserActions")
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
      user: UserStore
      chat: ChatStore
    willTransitionTo: (transition, params, query) ->
      ChatActions.setIntervalID setInterval(->
        ChatActions.fetchTopicInfo params.topic_id
      , 5000)
    willTransitionFrom: (transition, component) ->
      window.clearInterval(component.state.chat.intervalID)

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
