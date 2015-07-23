React = require "react"
mentions = require "react-mentions"
ReactBootstrap = require "react-bootstrap"
ChatActions = require("../../actions/ChatActions")
ChatStore = require("../../stores/ChatStore")
URLResources = require("../../common/URLResources")

{form} = React.DOM
MentionsInput = React.createFactory mentions.MentionsInput
Mention = React.createFactory mentions.Mention
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

ChatForm = React.createClass
  displayName: "ChatForm"

  propTypes:
    submitMessage: React.PropTypes.func.isRequired
    currentMessage: React.PropTypes.string.isRequired
    users: React.PropTypes.array.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  componentWillUnmount: ->
    ChatActions.setCurrentRoom null

  keyPress: (e) ->
    @state.keyPressMap[e.key] = (e.type == "keydown")
    controlOrShift = @state.keyPressMap["Control"] or
                      @state.keyPressMap["Shift"]
    if @state.keyPressMap["Enter"] and controlOrShift
      @state.currentMessage = @state.currentMessage + "\n"
    else if @state.keyPressMap["Enter"]
      @submit e

  submit: (e) ->
    @props.submitMessage e, @props.currentMessage.trim(), @state.mentions
    ChatActions.setCurrentMessage ""

  displayMention: (id, display, type) -> "@" + display

  formattedUserMentionsData: () ->
    @props.users.map ({username, id}) ->
      {id: id, display: username}

  inputChange: (e, newValue, newPlainTextValue, mentions) ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight
    ChatActions.setCurrentMessage e.target.value
    ChatActions.setMentions mentions

  render: ->
    form {className: "chat-form", autoComplete: off},
      MentionsInput
        value: @props.currentMessage
        onChange: @inputChange
        displayTransform: @displayMention
        onKeyUp: @keyPress
        onKeyDown: @keyPress,
        markup: "@[__display__](#)"
        Mention {trigger: "@", data: @formattedUserMentionsData()},

module.exports = ChatForm
