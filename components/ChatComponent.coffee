React = require "react"

{ div, form, li, ul } = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory(ReactBootstrap.Input)
Button = React.createFactory(ReactBootstrap.Button)

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    messageList: []
    message: ""

  componentDidMount: ->
    @socket = io("http://127.0.0.1:3001")
    @socket.on "chat message", (msg) =>
      newList = @state.messageList
      newList.push msg
      @setState messageList: newList

  submit: (e) ->
    @setState message: @state.message.trim()
    unless @state.message is "" 
      @socket.emit "chat message", @state.message
      @setState message: ""
    e.preventDefault()

  inputChange: (e) ->
    @setState message: e.target.value

  keyPress: (e) ->
    if e.key == "Enter"
      @submit e

  render: ->
    div {className: "chat"},
      form {className: "chat-form" },
        Input {type: "text", id: "chat-input", className: "form-input", autoComplete: off, value: @state.message, onChange: @inputChange, onKeyDown: @keyPress}, {}
        Button {onClick: @submit, className: "form-button"}, "send"
      ul {className: "unordered-list-messages"},
        @state.messageList.map (msg) ->
          li {className: "messages"}, msg

module.exports = ChatComponent
