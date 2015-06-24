React = require "react"

{ div, form, li, ul } = React.DOM
ReactBootstrap = require 'react-bootstrap'
Input = React.createFactory(ReactBootstrap.Input)
Button = React.createFactory(ReactBootstrap.Button)

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    messageList: []
    message: ''

  componentDidMount: ->
    @socket = io("http://127.0.0.1:3001")
    @socket.on "chat message", (msg) =>
      if msg == ""
        return
      newList = @state.messageList
      newList.push msg
      @setState messageList: newList

  click: (e) ->
    if @state.message == ""
      return
    @socket.emit "chat message", @state.message
    @setState message: ''
    e.stopPropagation()

  inputChange: (e) ->
    @setState message: e.target.value

  render: ->
    div {className: 'chat'},
      form {className: 'chat-form'},
        Input {type: 'text', id: "chat-input", autoComplete: off, value: @state.message, onChange: @inputChange}
        Button {onClick: @click, className: 'form-button'}, "send"
      ul {className: "unordered-list-messages"},
        @state.messageList.map (msg) ->
          li {className: "messages"}, msg

module.exports = ChatComponent
