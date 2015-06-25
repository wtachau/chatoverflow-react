React = require("react")
Router = require("react-router")
URLResources = require("../common/URLResources")

{ div } = React.DOM
TopicSidebar = React.createFactory (require "./chat/TopicSidebar")
MessageList = React.createFactory (require "./chat/MessageList")
ChatForm = React.createFactory (require "./chat/ChatForm")

io = require "socket.io-client"

ChatComponent = React.createClass

  propTypes: 
    user: React.PropTypes.object.isRequired,
    logoutClicked: React.PropTypes.func.isRequired

  mixins: [ Router.State ],

  getInitialState: ->
    messages: [],
    currentRoom: null

  componentWillMount: ->
    @setState currentRoom: @getParams().room
    @socket = io(URLResources.getChatServerOrigin())
    @socket.on "chat message", ({user_id, username, text}) =>
      newList = @state.messages
      newList.push {username, text}
      @setState messages: newList

  componentDidMount: ->
    URLResources.readFromAPI "/messages", (response)=>
      messages = response.map ({username, text}) -> {username, text}
      @setState messageList: messages

  submitMessage: (e, message) ->
    user_id = @props.user.id
    username = if @props.user.name then @props.user.name else @props.user.username
    room_id = 1 #todo
    unless message is  "" 
      @socket.emit "chat message", { user_id, username, room_id, "text": message }
    e.preventDefault()

  render: ->
    div {className: "chat"},
      TopicSidebar {}
      MessageList {messages: @state.messages}
      ChatForm {submitMessage: @submitMessage}

module.exports = ChatComponent
