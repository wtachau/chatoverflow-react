React = require "react"
{ div, form, input, button } = React.DOM

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    {messageList: []}

  componentDidMount: ->
    @socket = io("http://127.0.0.1:3001")
    @socket.on "chat message", (msg) =>
      @state.messageList.push msg
      console.log @state.messageList

  click: (e) ->
    @socket.emit "chat message", $("#chat-input").val()
    false

  render: ->
    form {onSubmit:@click},
      input {id:"chat-input", autocomplete:off}
      button {}, "send"

module.exports = ChatComponent