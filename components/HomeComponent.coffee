React = require("react")
ChatStore = require("../stores/ChatStore")
ChatActions = require("../actions/ChatActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

ReactBootstrap = require("react-bootstrap")
URLResources = require("../common/URLResources")
{ h1, form, div } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button
DropdownButton = React.createFactory ReactBootstrap.DropdownButton
MenuItem = React.createFactory ReactBootstrap.MenuItem

HomeComponent = React.createClass
  displayName: "HomeComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  inputChange: (e) ->
    ChatActions.setCurrentQuestion e.target.value

  keyPress: (e) ->
    if e.key is "Enter"
      @submitQuestion e

  successFunction: (response) ->
    console.log response

  errorFunction: ->
    console.log "errorFunction"

  submitQuestion: (e) ->
    unless @state.currentQuestion.trim() is ""
      URLResources.callAPI "/rooms", "post",
        {topic_id: @state.topicSelected.eventKey,
        text: @state.currentQuestion.trim()},
        @successFunction
      ChatActions.setCurrentQuestion ""

  onTopicSelected: (eventKey, href, target) ->
    ChatActions.setTopicSelected {eventKey, name: target}

  render: ->
    dropdownTitle = if @state.topicSelected
      @state.topicSelected.name
    else
      "Select a topic"

    div {className: "home"},
      Row {},
        Col xs: 8,
          h1 {}, "Select a Topic"
      Row {},
        Col xs: 4,
        DropdownButton title: dropdownTitle,
          @state.topics.map ({id, name}) =>
            MenuItem
              eventKey: id
              target: name
              onSelect: @onTopicSelected,
              name
      if @state.topicSelected
        div {},
          Row {},
            Col xs: 12,
              h1 {}, "What's your #{@state.topicSelected.name} question?"
          Row {},
            Col xs: 4, {},
              form {className: "welcome-form", autoComplete: off},
                Input
                  type: "text"
                  className: "welcome-input"
                  autoComplete: off
                  value: @state.question
                  onChange: @inputChange
                  onKeyDown: @keyPress
            Col xs: 4, {},
                Button
                  className: "welcome-form-button"
                  onClick: @submitQuestion,
                  "Submit"

module.exports = HomeComponent

