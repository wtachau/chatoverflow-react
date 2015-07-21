React = require("react")
AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
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

  componentWillReceiveProps: (newProps) ->
    unless newProps.params.topic_id is @state.chat.topicSelected
      ChatActions.setTopicSelected newProps.params.topic_id

  componentDidMount: ->
    unless @props.params.topic_id is @state.chat.topicSelected
      ChatActions.setTopicSelected @props.params.topic_id

  render: ->
    div {className: "main-section"},
      RouteHandler {}
      RoomList
        currentTopic: @getParams().topic_id

module.exports = TopicComponent
