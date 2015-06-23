React = require "react"
{ div, form, input, button } = React.DOM
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
      newList = @state.messageList
      newList.push msg
      @setState { messageList: newList, message: '' }

  click: (e) ->
    @socket.emit "chat message", @state.message
    e.stopPropagation()

  inputChange: (e) ->
    @setState message: e.target.value

  render: ->
    form {},
      Input {type: 'text', id: "chat-input", autoComplete: off, value: @state.message, onChange: @inputChange}
      Button {onClick: @click}, "send"

module.exports = ChatComponent
