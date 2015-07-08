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

HomeComponent = React.createClass
  displayName: "HomeComponent"

  mixins: [ReactStateMagicMixin, Router.Navigation]

  statics:
    registerStores:
      chat: ChatStore
      app: AppStore

  inputChange: (e) ->
    ChatActions.setCurrentQuestion e.target.value

  keyPress: (e) ->
    if e.key is "Enter"
      @submitQuestion e

  componentWillMount: ->
    @socket = io(URLResources.getChatServerOrigin())

  successFunction: (response) ->
    @socket.emit "chat message",
      user_id: @state.app.user.id
      username: @state.app.user.username
      room_id: response.id
      text: @state.chat.currentQuestion
      mentions: []
    AppActions.fetchUser()
    ChatActions.setCurrentQuestion ""
    @transitionTo 'room', room_id: response.id

  errorFunction: ->
    console.log "errorFunction"

  submitQuestion: (e) ->
    unless @state.chat.currentQuestion.trim() is ""
      URLResources.callAPI "/rooms", "post",
        {topic_id: @state.chat.topicSelected.eventKey,
        text: @state.chat.currentQuestion.trim()},
        @successFunction
      e.preventDefault()

  onTopicSelected: (eventKey, href, target) ->
    ChatActions.setTopicSelected {eventKey, name: target}

  render: ->
    dropdownTitle = if @state.chat.topicSelected
      @state.chat.topicSelected.name
    else
      "Select a topic"

    div {className: "home"},
      Row {},
        Col md: 8, mdOffset: 2,
          h1 {}, "Select a Topic"
      Row {},
        Col md: 4, mdOffset: 2,
        DropdownButton title: dropdownTitle,
          @state.chat.topics.map ({id, name}, index) =>
            MenuItem
              eventKey: id
              target: name
              onSelect: @onTopicSelected,
              key: index
              name
      if @state.chat.topicSelected
        div {},
          Row {},
            Col md: 12,
              h1 {}, "What's your #{@state.chat.topicSelected.name} question?"
          Row {},
            Col md: 8, mdOffset: 2,
              form {className: "welcome-form", autoComplete: off},
                Input
                  type: "text"
                  className: "welcome-input"
                  autoComplete: off
                  value: @state.chat.question
                  onChange: @inputChange
                  onKeyDown: @keyPress
                Button
                  className: "welcome-form-button"
                  onClick: @submitQuestion
                  "Submit"

module.exports = HomeComponent

