React = require("react")
io = require("socket.io-client")
ChatStore = require("../stores/ChatStore")
UserStore = require("../stores/UserStore")
ChatActions = require("../actions/ChatActions")
UserActions = require("../actions/UserActions")
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
      user: UserStore

  questionTitleChange: (e) ->
    ChatActions.setCurrentQuestionTitle e.target.value

  questionTextChange: (e) ->
    ChatActions.setCurrentQuestionText e.target.value

  keyPress: (e) ->
    if e.key is "Enter"
      @submitQuestion e
      e.preventDefault()

  # Initialize socket.io connection
  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

  componentWillUpdate: (nextProps, nextState) ->
    if @state.chat.topics.length == 0 and nextState.chat.topics.length > 0
      @setRandomTopic()

  componentDidMount: ->
    ChatActions.fetchTopics()

  setRandomTopic: ->
    setTimeout =>
      if @state.chat.topics.length > 0
        numberTopics = @state.chat.topics.length
        randomIndex = Math.round(numberTopics * Math.random())
        randomTopic = @state.chat.topics[randomIndex]
        ChatActions.setTopicSelected randomTopic.id

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
    UserActions.fetchUser()
    ChatActions.setCurrentQuestionText ""
    ChatActions.setCurrentQuestionTitle ""
    
    @transitionTo 'room', room_id: response.id, topic_id: response.topic_id

  onTopicSelected: (eventKey, href, target) ->
    ChatActions.setTopicSelected eventKey

  render: ->
    dropdownTitle = ""
    dropdownTitle = if @state.chat.topicSelected
      if @state.chat.topics
        for topic in @state.chat.topics
          if topic.id is parseInt(@state.chat.topicSelected)
            dropdownTitle = topic.name

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
                  onKeyDown: @keyPress
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

