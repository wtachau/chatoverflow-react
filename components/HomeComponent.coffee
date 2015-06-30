React = require("react")

ReactBootstrap = require("react-bootstrap")
{ h1, form, div } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button
DropdownButton = React.createFactory ReactBootstrap.DropdownButton
MenuItem = React.createFactory ReactBootstrap.MenuItem

HomePageComponent = React.createClass

  getInitialState: ->
    buttonText: "Next"
    question: ""
    questionEntered: false
    topicSelected: "Choose a topic"

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

  onTopicSelected: (eventKey, href, target) ->
    @setState topicSelected: target


  getTopics: ->
    topics = [
      {id: 1, topic: "java"},
      {id: 2, topic: "php"},
      {id: 3, topic: "android"},
      {id: 4, topic: "ios"},
      {id: 5, topic: "css"},
      {id: 6, topic: "ruby"},
      {id: 7, topic: "scala"}
    ]

  render: ->
    div {className: "home"},
      Row {},
        Col xs: 8,
          h1 {}, "Select a Topic"
      Row {},
        Col xs: 8,
        Col xs: 4,
        DropdownButton title: @state.topicSelected,
          @getTopics().map ({id, topic}) =>
            MenuItem {eventKey: id, target: topic, onSelect: @onTopicSelected}, topic 
      if @state.topicSelected isnt "Choose a topic"
        div {},
          Row {},
            Col xs: 12, 
              h1 {}, "What's your " + @state.topicSelected + " question ?"
          Row {},
            Col xs: 4, {},
              form {className: "welcome-form", autoComplete: off},
                Input {type: "text", className: "welcome-input", id: "welcome-input", autoComplete: off, value: @state.question, onChange: @inputChange, onKeyDown: @keyPress}
            Col xs: 4, {},
                Button {className: "welcome-form-button", onClick: @onQuestionEntered}, @state.buttonText
      if @state.questionEntered and @state.topicSelected
        div {},
          Row {},
            Col xs: 12, "Your question: " + @state.question

module.exports = HomePageComponent
