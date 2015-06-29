React = require("react")

{ ul, li, div } = React.DOM
Message = React.createFactory require("./Message")
URLResources = require("../../common/URLResources")

MessageList = React.createClass
  propTypes: 
    messages: React.PropTypes.array.isRequired

  getInitialState: ->
    messages: []

  componentWillMount: ->
    @props.socket.emit "subscribe", {username: @props.username, room: @props.currentRoom}
    @props.socket.on "chat message", ({user_id, username, room_id, text}) =>
      if room_id == @props.currentRoom
        newList = @state.messages
        newList.push {username, text}
        @setState messages: newList

  componentDidMount: ->
    @fetchRoomHistory(@props.currentRoom)

  componentWillReceiveProps: (nextProps) ->
    @props.socket.emit "subscribe", {username: @props.username, room: nextProps.currentRoom}
    @props.socket.emit "unsubscribe", {username: @props.username, room: @props.currentRoom}
    @fetchRoomHistory nextProps.currentRoom

  componentDidUpdate: ->
    component = React.findDOMNode(this)
    component.scrollTop = component.scrollHeight

  fetchRoomHistory: (room_id) ->
    URLResources.readFromAPI "/rooms/#{room_id}/messages", (response)=>
      messages = response.map ({username, text}) -> {username, text}
      @setState messages: messages

  render: ->
    div {className: "messages"},
      @state.messages.map ({username, text}, index) ->
        oddClass = if index % 2 == 1 then "odd" else ""
        Message username: username, text: text, key: index, className: oddClass

module.exports = MessageList
