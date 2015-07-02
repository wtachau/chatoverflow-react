React = require("react")

{ div, button } = React.DOM
Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

MessageList = React.createClass
  displayName: "MessageList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores: 
      app: AppStore

  propTypes: 
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  componentDidUpdate: ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight

  followRoom: ->
    action = if @followingCurrentRoom() then AppActions.unfollowRoom else AppActions.followRoom
    action @props.currentRoom

  followingCurrentRoom: ->
    followedRoomIds = @state.app.user.followed_rooms.map ({id}) -> id
    parseInt(@props.currentRoom) in followedRoomIds

  buttonText: ->
    if @followingCurrentRoom()
      'Unfollow Room'
    else
      'Follow Room'

  render: ->
    div {className: "messages"},
      button {onClick: @followRoom}, @buttonText()
      @props.messages.map ({username, text, created_at}, index) ->
        oddClass = if index % 2 == 1 then "odd" else ""
        Message username: username, text: text, key: index, className: oddClass, timestamp: created_at

module.exports = MessageList
