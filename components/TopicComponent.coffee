React                = require("react")
io                   = require("socket.io-client")
UserStore            = require("../stores/UserStore")
UserActions          = require("../actions/UserActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
URLResources         = require("../common/URLResources")
FollowResources      = require("../common/FollowResources")
Router               = require("react-router")
RoomStore            = require("../stores/RoomStore")
RoomActions          = require("../actions/RoomActions")

RoomList     = React.createFactory require("./chat/RoomList")
RouteHandler = React.createFactory Router.RouteHandler

{ div } = React.DOM

TopicComponent = React.createClass
  displayName: "TopicComponent"

  mixins: [Router.State, ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      room: RoomStore
    willTransitionTo: (transition, params, query) ->
      RoomActions.setIntervalID setInterval(->
        RoomActions.fetchTopicInfo params.topic_id
      , 5000)
    willTransitionFrom: (transition, component) ->
      window.clearInterval(component.state.room.intervalID)

  componentWillReceiveProps: (newProps) -> @updateTopicSelected(newProps)
  componentDidMount: -> @updateTopicSelected(@props)

  updateTopicSelected: (props) ->
    setTimeout =>
      unless props.params.topic_id is @state.room.topicSelected
        RoomActions.setTopicSelected props.params.topic_id

  render: ->
    div {className: "main-section"},
      RouteHandler {socket: @props.socket}
      RoomList
        currentTopic: @getParams().topic_id

module.exports = TopicComponent
