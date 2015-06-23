React = require "react"
{ div, form, input, button } = React.DOM

io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass

  componentWillMount: ->
    @socket = io("http://127.0.0.1:3001")

  click: (e) ->
    @socket.emit "chat message", $("#chat-input").val()
    false

  render: ->
    form {onSubmit:@click},
      input {id:"chat-input", autocomplete:off}
      button {}, "send"

module.exports = ChatComponent