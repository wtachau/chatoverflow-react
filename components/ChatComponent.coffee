React = require "react"
{ div, form, input, button, li, ul} = React.DOM


io = require "socket.io-client"
$ = require "jquery"

ChatComponent = React.createClass
  getInitialState: ->
    {messageList: []}

  componentDidMount: ->
    @socket = io("http://127.0.0.1:3001")
    @socket.on "chat message", (msg) =>
      @state.messageList.push msg
      @setState messageList:@state.messageList

  click: (e) ->
    @socket.emit "chat message", $("#chat-input").val()
    $("#chat-input").val('')
    false

  render: ->
    div {}, 
      form {onSubmit:@click, className: "chat-form"},
        input {id:"chat-input", autocomplete:off, className: "form-input"}
        button {className: "form-button"}, "send"
      ul {className: "unordered-list-messages"}, 
        @state.messageList.map (msg) -> 
          li {className:"messages"}, msg
module.exports = ChatComponent
