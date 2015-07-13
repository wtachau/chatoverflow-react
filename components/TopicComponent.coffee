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

  isFollowingTopic: (topic_id) ->
    followedTopicIds = @state.user.followed_topics.map ({id}) -> id
    parseInt(topic_id) in followedTopicIds

  render: ->
    div {className: "main-section"},
      RoomList
        currentTopic: @getParams().topic_id
        isFollowingTopic: @isFollowingTopic
      RouteHandler {}

module.exports = TopicComponent
