React = require("react")
io = require("socket.io-client")

{ div } = React.DOM
TopicSidebar = React.createFactory require("./chat/TopicSidebar")
MessageList = React.createFactory require("./chat/MessageList")
ChatForm = React.createFactory require("./chat/ChatForm")
HomeComponent = React.createFactory require("./HomeComponent")
URLResources = require("../common/URLResources")

ChatComponent = React.createClass

  propTypes: 
    user: React.PropTypes.object.isRequired,
    logoutClicked: React.PropTypes.func.isRequired,
    room: React.PropTypes.number.isRequired

  username: ->
    @props.user.name or @props.user.username

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

  submitMessage: (e, message) ->
    unless message is "" 
      @socket.emit "chat message", { user_id: @props.user.id, username: @username(), room_id:@props.currentRoom, "text": message.trim() }
    e.preventDefault()

  render: ->
    mainSection = if @props.currentRoom then (
      div {},
        MessageList {currentRoom: @props.currentRoom, socket: @socket, username: @username()}
        ChatForm {submitMessage: @submitMessage} )
    else
      HomeComponent {}

    div {className: "chat"},
      TopicSidebar {}
      mainSection
      

module.exports = ChatComponent
