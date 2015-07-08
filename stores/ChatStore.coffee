alt = require("../alt")
ChatActions = require("../actions/ChatActions")

class ChatStore
  displayName: "ChatStore"

  constructor: ->
    @currentMessage = ""
    @messages = []
    @topics = []
    @mentions = []
    @currentQuestion = ""
    @topicSelected = null
    @topicInfo = null
    @currentPage = null

    @bindActions(ChatActions)

  onSetCurrentQuestion: (question) ->
    @currentQuestion = question

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetCurrentPage: (page) ->
    @currentPage = page
    console.log @currentPage

  onSetMessage: (message) ->
    for m, i in @messages
      if m.id is message.id
        @messages[i] = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onAddToMessages: (messages) ->
    #console.log "adding to messages:"
    #console.log messages
    #console.log "@messages"
    #console.log @messages
    @messages = messages.concat(@messages)
    #console.log "together"
    #console.log @messages

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicSelected: (topicSelected) ->
    @topicSelected = topicSelected

  onSetTopicInfo: (topicInfo) ->
    @topicInfo = topicInfo

  onSetMentions: (mentions) ->
    @mentions = mentions

module.exports = alt.createStore(ChatStore)
