React = require "react"
mentions = require "react-mentions"
ReactBootstrap = require "react-bootstrap"
ChatActions = require("../../actions/ChatActions")
ChatStore = require("../../stores/ChatStore")
URLResources = require("../../common/URLResources")

{form} = React.DOM
Button = React.createFactory ReactBootstrap.Button
MentionsInput = React.createFactory mentions.MentionsInput
Mention = React.createFactory mentions.Mention
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

ChatForm = React.createClass
  displayName: "ChatForm"

  propTypes:
    submitMessage: React.PropTypes.func.isRequired
    currentMessage: React.PropTypes.string.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  keyPress: (e) ->
    @state.keyPressMap[e.key] = e.type == "keydown"
    if @state.keyPressMap["Enter"] and @state.keyPressMap["Control"] or @state.keyPressMap["Shift"]
      @state.currentMessage = @state.currentMessage + {"/n"}
    else if @state.keyPressMap["Enter"]
      @submit e

  submit: (e) ->
    @props.submitMessage e, @props.currentMessage.trim(), @state.mentions
    ChatActions.setCurrentMessage ""
    component = React.findDOMNode this
    component.scrollTop = 0

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
        Mention {trigger: "@", data: @formattedUserMentionsData()},
      Button {onClick: @submit, className: "form-button"}, "send"

module.exports = ChatForm
