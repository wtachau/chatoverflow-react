React = require "react"
{form} = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button

ChatForm = React.createClass
  propTypes:
    submitMessage: React.PropTypes.func.isRequired

  getInitialState: ->
    message: ""

  keyPress: (e) ->
    if e.key == "Enter"
      @props.submitMessage e, @state.message.trim()
      @setState message: ""

  submit: (e) ->
    @props.submitMessage e, @state.message.trim()

  inputChange: (e) ->
    @setState message: e.target.value

  render: ->
    form {className: "chat-form", autoComplete: off},
      Input {type: "text", id: "chat-input", className: "form-input", autoComplete: off, value: @state.message, onChange: @inputChange, onKeyDown: @keyPress} 
      Button {onClick: @submit, className: "form-button"}, "send"

module.exports = ChatForm
