React = require("react")
AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Router = require("react-router")
RouteHandler = React.createFactory Router.RouteHandler
RoomList = React.createFactory require("./chat/RoomList")
{ div } = React.DOM

TopicComponent = React.createClass
  displayName: "TopicComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStore: AppStore

  render: ->
    div {className: "main-section"},
      RoomList
        currentTopic: @getParams().topic_id
      RouteHandler {}

module.exports = TopicComponent
