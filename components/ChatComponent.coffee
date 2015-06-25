React = require "react"

{ div } = React.DOM
TopicSidebar = React.createFactory (require "./chat/TopicSidebar")
MessageList = React.createFactory (require "./chat/MessageList")
ChatForm = React.createFactory (require "./chat/ChatForm")

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    messages: []

  componentWillMount: ->
    @socket = io(@props.getChatServerOrigin())
    @socket.on "chat message", ({user_id, username, text}) =>
      newList = @state.messages
      newList.push {username, text}
      @setState messages: newList

  componentDidMount: ->
    @props.readFromAPI "#{ @props.getLogicServerOrigin() }/messages", (response)=>
      messages = response.map ({username, text}) -> {username, text}
      @setState messageList: messages

  submitMessage: (e, message) ->
    user_id = @props.user.id
    username = @props.user.name
    room_id = 1 #todo
    unless message is  "" 
      @socket.emit "chat message", { user_id, username, room_id, "text": message }
    e.preventDefault()

  render: ->
    div {className: "chat"},
      TopicSidebar {}
      MessageList {messages: @state.messages}
      ChatForm {submitMessage: @submitMessage}

module.exports = ChatComponent
