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

  componentWillMount: ->
    @socket = switch process.env.NODE_ENV
      when 'development' then io("http://127.0.0.1:3001")
      when 'staging' then io("http://chat-overflow-node-staging.herokuapp.com")
    @socket.on "chat message", ({user_id, user_name, message}) =>
      newList = @state.messageList
      newList.push {user_name, message}
      @setState messageList: newList

  click: (e) ->
    user_id = 1
    user_name = "Willy" #fixme
    @socket.emit "chat message", { user_id, user_name, "message":@state.message }
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
        @state.messageList.map ({user_name, message}) ->
          li {className: "messages"}, user_name+": "+message

module.exports = ChatComponent
