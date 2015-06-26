React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./chat/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
HomePageComponent = React.createFactory require("./HomePageComponent")
URLResources = require("../common/URLResources")

ChatComponent = React.createClass

  propTypes: 
    user: React.PropTypes.object.isRequired,
    logoutClicked: React.PropTypes.func.isRequired,
    room: React.PropTypes.number.isRequired

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())
    @username = if @props.user.name then @props.user.name else @props.user.username

  submitMessage: (e, message) ->
    unless message is "" 
      @socket.emit "chat message", { user_id: @props.user.id, username: @username, room_id:@props.currentRoom, "text": message.trim() }
    e.preventDefault()

  render: ->
    mainSection = if @props.currentRoom then (
      div {},
        MessageList {currentRoom: @props.currentRoom, socket: @socket, username: @username}
        ChatForm {submitMessage: @submitMessage} )
    else
      HomePageComponent {}

    div {className: "chat"},
      TopicSidebar {}
      mainSection
      

module.exports = ChatComponent
