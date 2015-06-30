React = require("react")

ReactBootstrap = require("react-bootstrap")
{ h1, form, div } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button

HomePageComponent = React.createClass

  getInitialState: ->
    buttonText: "Next"
    inputMessage: "testing"

  keyPress: (e) ->
    if e.key is "Enter"
      @props.submitMessage e, @state.inputMessage.trim()
      @setState inputMessage: ""

  submit: (e) ->
    @props.submitMessage e, @state.inputMessage.trim()

  render: ->
    div {className: "home"},
      Row {}
        Col xs: 12, 
          h1 {}, "Ask a question!"
      Row {}
        Col xs: 1, {}
          form {className: "welcome-form", autoComplete: off},
            Input {text: "text", className: "welcome-input", id: "welcome-input", autoComplete: off, value: @state.inputMessage, onChange: @inputChange, onKeyDown: @keyPress}
            Button {className: "welcome-form-button", onClick: @submit}, @state.buttonText

module.exports = HomePageComponent
