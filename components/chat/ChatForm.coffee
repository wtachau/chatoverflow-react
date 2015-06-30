React = require "react"
{form} = React.DOM
ReactBootstrap = require "react-bootstrap"
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button

mentions = require "react-mentions"
MentionsInput = React.createFactory mentions.MentionsInput
Mention = React.createFactory mentions.Mention

ChatForm = React.createClass
  propTypes:
    submitMessage: React.PropTypes.func.isRequired

  getInitialState: ->
    message: "",
    users: [{id: 1, display: "bob"},{id: 2, display: "bjones"}],
    mentions: []

  keyPress: (e) ->
    if e.key == "Enter"
      @props.submitMessage e, @state.message.trim()
      @setState message: ""

  submit: (e) ->
    @props.submitMessage e, @state.message.trim()

  inputChange: (e, newValue, newPlainTextValue, mentions) ->
    @setState message: e.target.value
    @setState mentions: mentions

  displayMention: (id, display, type) -> "@" + display

  render: ->
    form {className: "chat-form", autoComplete: off},
      MentionsInput {value: @state.message, onChange: @inputChange, displayTransform: @displayMention, singleLine: true, onKeyDown: @keyPress},
        Mention {trigger: "@", data: @state.users}, 
      Button {onClick: @submit, className: "form-button"}, "send"

module.exports = ChatForm
