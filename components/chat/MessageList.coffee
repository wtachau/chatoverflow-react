React = require("react")

{ ul, li, div, button } = React.DOM
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
    if @followingCurrentRoom()
      AppActions.unfollowRoom @props.currentRoom
    else
      AppActions.followRoom @props.currentRoom

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
      @props.messages.map ({username, text}, index) ->
        oddClass = if index % 2 == 1 then "odd" else ""
        Message username: username, text: text, key: index, className: oddClass

module.exports = MessageList
