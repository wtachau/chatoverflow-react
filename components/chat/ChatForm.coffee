React = require "react"
mentions = require "react-mentions"
ReactBootstrap = require "react-bootstrap"
ThreadActions = require("../../actions/ThreadActions")
RoomStore = require("../../stores/RoomStore")
URLResources = require("../../common/URLResources")

{form} = React.DOM
MentionsInput = React.createFactory mentions.MentionsInput
Mention = React.createFactory mentions.Mention
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

ChatForm = React.createClass
  displayName: "ChatForm"

  propTypes:
    submitMessage: React.PropTypes.func.isRequired
    users: React.PropTypes.array.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: RoomStore
    
  getInitialState: ->
    message: ""
    mentions: []
    keyPressMap: {}

  componentWillUnmount: ->
    ThreadActions.setCurrentRoom null

  keyPress: (e) ->
    @state.keyPressMap[e.key] = (e.type == "keydown")
    controlOrShift = @state.keyPressMap["Control"] or
                      @state.keyPressMap["Shift"]
    if @state.keyPressMap["Enter"] and controlOrShift
      @setState message: @state.message + "\n"
    else if @state.keyPressMap["Enter"]
      @submit e

  submit: (e) ->
    @props.submitMessage e, @state.message.trim(), @state.mentions
    @setState message: ""

  displayMention: (id, display, type) -> "@" + display

  formattedUserMentionsData: () ->
    @props.users.map ({username, id}) ->
      {id: id, display: username}

  inputChange: (e, newValue, newPlainTextValue, mentions) ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight
    @setState message: e.target.value
    @setState mentions: mentions

  render: ->
    form {className: "chat-form", autoComplete: off},
      MentionsInput
        value: @state.message
        onChange: @inputChange
        displayTransform: @displayMention
        onKeyUp: @keyPress
        onKeyDown: @keyPress,
        markup: "@[__display__](#)"
        Mention {trigger: "@", data: @formattedUserMentionsData()},

module.exports = ChatForm
