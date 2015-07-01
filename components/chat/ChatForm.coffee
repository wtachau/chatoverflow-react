React = require "react"
{form} = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button
ChatActions = require("../../actions/ChatActions")

ChatForm = React.createClass
  displayName: "ChatForm"

  propTypes:
    submitMessage: React.PropTypes.func.isRequired
    currentMessage: React.PropTypes.string.isRequired

  keyPress: (e) ->
    if e.key is "Enter"
      @props.submitMessage e, @props.currentMessage.trim()
      ChatActions.setCurrentMessage ""

  submit: (e) ->
    @props.submitMessage e, @props.currentMessage.trim()
    ChatActions.setCurrentMessage ""

  inputChange: (e) ->
    ChatActions.setCurrentMessage e.target.value

  render: ->
    form {className: "chat-form", autoComplete: off},
      Input
        type: "text"
        id: "chat-input"
        className: "form-input"
        autoComplete: off
        value: @props.currentMessage
        onChange: @inputChange
        onKeyDown: @keyPress
      Button {onClick: @submit, className: "form-button"}, "send"

module.exports = ChatForm
