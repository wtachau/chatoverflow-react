alt = require("../alt")
ChatActions = require("../actions/ChatActions")

class ChatStore
  displayName: 'ChatStore'
  
  constructor: ->
    @currentMessage = ""
    @messages = []
    @topics = []
    @currentQuestion = ""
    @topicSelected = null

    @bindActions(ChatActions)

  onSetCurrentQuestion: (question) ->
    @currentQuestion = question

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicSelected: (topicSelected) ->
    @topicSelected = topicSelected


module.exports = alt.createStore(ChatStore)
