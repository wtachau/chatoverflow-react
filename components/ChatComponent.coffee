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

  componentWillMount: ->
    @socket = switch process.env.NODE_ENV
      when 'development' then io("http://127.0.0.1:3001")
      when 'staging' then io("http://chat-overflow-node-staging.herokuapp.com")
    @socket.on "chat message", ({user_id, user_name, message}) =>
      newList = @state.messageList
      newList.push {user_name, message}
      @setState messageList: newList

  submit: (e) ->
    user_id = 1
    user_name = "Willy" #fixme
    @setState message: @state.message.trim()
    unless @state.message is "" 
      @socket.emit "chat message", { user_id, user_name, "message": @state.message.trim() }
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
        @state.messageList.map ({user_name, message}) ->
          li {className: "messages"}, "#{user_name}: #{message}"

module.exports = ChatComponent
