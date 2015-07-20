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
    unless newProps.params.topic_id is @state.chat.topicSelectedByPrev
      ChatActions.setTopicSelectedByPrev newProps.params.topic_id

  componentDidMount: ->
    ChatActions.setTopicSelectedByPrev @props.params.topic_id

  render: ->
    div {className: "main-section"},
      RoomList
        currentTopic: @getParams().topic_id
      RouteHandler {}

module.exports = TopicComponent
