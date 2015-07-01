React = require("react")

ReactBootstrap = require("react-bootstrap")
{ h1, form, div } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button
DropdownButton = React.createFactory ReactBootstrap.DropdownButton
MenuItem = React.createFactory ReactBootstrap.MenuItem

HomeComponent = React.createClass
  displayName: "HomeComponent"

  getInitialState: ->
    buttonText: "Next"
    question: ""
    questionEntered: false
    topic: null

  keyPress: (e) ->
    if e.key is "Enter"
      @submitQuestion()

  onQuestionEntered: (e) ->
    @setState questionEntered: not @state.questionEntered 
    if @state.buttonText is "Next" then @setState buttonText: "Back" else @setState buttonText: "Next"

  inputChange: (e) ->
    @setState question: e.target.value

  submitQuestion:  ->
    console.log "todo"
    # todo: writeToAPI then render different component

  render: ->
    div {className: "home"},
        Row {},
          Col xs: 8, 
            h1 {}, "Ask a question!"
        Row {},
          Col xs: 4, {},
            form {className: "welcome-form", autoComplete: off},
              Input {type: "text", className: "welcome-input", id: "welcome-input", autoComplete: off, value: @state.question, onChange: @inputChange, onKeyDown: @keyPress}
          Col xs: 4, {},
              Button {className: "welcome-form-button", onClick: @onQuestionEntered}, @state.buttonText
        if @state.questionEntered
          Row {},
            Col xs: 8,
            #Button {className: "welcome-form-button", onClick: @onQuestionEntered}, "Back"
            Col xs: 4,
              DropdownButton title: "Choose a topic",
                MenuItem eventKey = '1', "Java"
                MenuItem eventKey = '2', "Android"
                MenuItem eventKey = '3', "iOS"

module.exports = HomeComponent
