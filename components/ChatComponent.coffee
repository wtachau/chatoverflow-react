React = require "react"

{ div, form, li, ul } = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory(ReactBootstrap.Input)
Button = React.createFactory(ReactBootstrap.Button)
ListGroup = React.createFactory(ReactBootstrap.ListGroup)
ListGroupItem = React.createFactory(ReactBootstrap.ListGroupItem)

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    messageList: []
    message: ""

  componentWillMount: ->
    @socket = io(@props.getChatServerOrigin())
    @socket.on "chat message", ({user_id, username, text}) =>
      newList = @state.messageList
      newList.push {username, text}
      @setState messageList: newList

  componentDidMount: ->
    @props.readFromAPI "#{ @props.getLogicServerOrigin() }/messages", (response)=>
      messages = response.map ({username, text}) -> {username, text}
      @setState messageList: messages

  submit: (e) ->
    user_id = @props.user.id
    username = @props.user.name
    room_id = 1 #todo
    trimmed = @state.message.trim()
    unless trimmed is  "" 
      @socket.emit "chat message", { user_id, username, room_id, "text": trimmed }
    @setState message: ""
    e.preventDefault()

  inputChange: (e) ->
    @setState message: e.target.value

  keyPress: (e) ->
    if e.key == "Enter"
      @submit e

  render: ->
    div {className: "chat"},
      ListGroup {className: "side-bar"},
        ListGroupItem {}, "Ruby"
        ListGroupItem {}, "Java"
        ListGroupItem {}, "C++"
        ListGroupItem {}, "Scala"
        ListGroupItem {}, "Android"
        ListGroupItem {}, "iOS"
      ul {className: "unordered-list-messages"},
        @state.messageList.map ({username, text}) ->
          li {className: "messages"}, "#{username}: #{text}"
      form {className: "chat-form", autoComplete: off},
        Input {type: "text", id: "chat-input", className: "form-input", autoComplete: off, value: @state.message, onChange: @inputChange, onKeyDown: @keyPress} 
        Button {onClick: @submit, className: "form-button"}, "send"

module.exports = ChatComponent
