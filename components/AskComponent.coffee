React = require("react")
io = require("socket.io-client")
ChatStore = require("../stores/ChatStore")
AppStore = require("../stores/AppStore")
ChatActions = require("../actions/ChatActions")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Router = require("react-router")

ReactBootstrap = require("react-bootstrap")
URLResources = require("../common/URLResources")
{ h1, form, div } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
Input = React.createFactory ReactBootstrap.Input
Button = React.createFactory ReactBootstrap.Button
DropdownButton = React.createFactory ReactBootstrap.DropdownButton
MenuItem = React.createFactory ReactBootstrap.MenuItem

AskComponent = React.createClass
  displayName: "AskComponent"

  mixins: [ReactStateMagicMixin, Router.Navigation]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  questionTitleChange: (e) ->
    ChatActions.setCurrentQuestionTitle e.target.value

  questionTextChange: (e) ->
    ChatActions.setCurrentQuestionText e.target.value

  keyPress: (e) ->
    if e.key is "Enter"
      @submitQuestion e

  # Initialize socket.io connection
  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

  componentDidMount: ->
    ChatActions.fetchTopics()

  # Send a new question to the node server
  submitQuestion: (e) ->
    unless (@state.chat.currentQuestionText.trim() is "") or
    (@state.chat.currentQuestionTitle.trim() is "")
      URLResources.callAPI "/rooms", "post",
        {topic_id: @state.chat.topicSelected,
        title: @state.chat.currentQuestionTitle.trim(),
        text: @state.chat.currentQuestionText.trim()},
        @onSubmitQuestion
      e.preventDefault()

  # After a new question is created, reset parameters
  onSubmitQuestion: (response) ->
    AppActions.fetchUser()
    ChatActions.setCurrentQuestionText ""
    ChatActions.setCurrentQuestionTitle ""
    
    @transitionTo 'room', room_id: response.id, topic_id: response.topic_id

  onTopicSelected: (eventKey, href, target) ->
    ChatActions.setTopicSelected eventKey

  render: ->
    dropdownTitle = if @state.chat.topicSelected
      @state.chat.topics[@state.chat.topicSelected - 1]?.name
    else
      "Select a Topic"

    div {className: "home"},
      Row {},
        Col md: 12,
          h1 {className: "question-header"}, 
            "What is your "
            DropdownButton title: dropdownTitle,
              @state.chat.topics.map ({id, name}, index) =>
                MenuItem
                  eventKey: id
                  target: name
                  onSelect: @onTopicSelected,
                  key: index
                  name
            " question?"
      if @state.chat.topicSelected
        div {},
          Row {},
            Col md: 8, mdOffset: 2,
              form {className: "ask-form", autoComplete: off},
                Input
                  type: "text"
                  className: "ask-title"
                  autoComplete: off
                  value: @state.chat.currentQuestionTitle
                  onChange: @questionTitleChange
                  placeholder: "Title for your question (required)"
                Input
                  type: "textarea"
                  className: "ask-question"
                  value: @state.chat.currentQuestionText
                  onChange: @questionTextChange
                  onKeyDown: @keyPress
                  placeholder: "Describe your question (required)"
                Button
                  className: "ask-form-button"
                  onClick: @submitQuestion
                  "Submit"

module.exports = AskComponent

