React = require("react")
URLResources = require("../common/URLResources")

{ div, form, li, ul } = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory(ReactBootstrap.Input)
Button = React.createFactory(ReactBootstrap.Button)

io = require "socket.io-client"

ChatComponent = React.createClass
  getInitialState: ->
    messageList: []
    message: ""

  componentWillMount: ->
    @URLResources = new URLResources()
    @socket = io(@URLResources.getChatServerOrigin())
    @socket.on "chat message", ({user_id, username, text}) =>
      newList = @state.messageList
      newList.push {username, text}
      @setState messageList: newList

  componentDidMount: ->
    @URLResources.readFromAPI "#{ @URLResources.getLogicServerOrigin() }/messages", (response)=>
      messages = response.map ({username, text}) -> {username, text}
      @setState messageList: messages

  submit: (e) ->
    user_id = @props.user.id
    username = @props.user.name
    room_id = 1 #todo
    @setState message: @state.message.trim()
    unless @state.message is "" 
      @socket.emit "chat message", { user_id, username, room_id, "text": @state.message.trim() }
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
        @state.messageList.map ({username, text}) ->
          li {className: "messages"}, "#{username}: #{text}"

module.exports = ChatComponent
