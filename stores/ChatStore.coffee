alt = require("../alt")
ChatActions = require("../actions/ChatActions")

class ChatStore
  displayName: "ChatStore"

  constructor: ->
    @currentMessage = ""
    @messages = []
    @topics = []
    @mentions = []
    @currentQuestionTitle = ""
    @currentQuestionText = ""
    @topicSelected = null
    @topicInfo = null
    @currentRoom = null
    @keyPressMap = []

    @bindActions(ChatActions)

  onSetCurrentQuestionTitle: (questionTitle) ->
    @currentQuestionTitle = questionTitle

  onSetCurrentQuestionText: (questionText) ->
    @currentQuestionText = questionText

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetCurrentRoom: (room) ->
    @currentRoom = room
    @messages = room?.messages

  onSetMessage: (message) ->
    for m, i in @messages
      if m.id is message.id
        @messages[i] = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicSelected: (topicSelected) ->
    @topicSelected = topicSelected

  onSetTopicInfo: (topicInfo) ->
    @topicInfo = topicInfo

  onSetMentions: (mentions) ->
    @mentions = mentions

module.exports = alt.createStore(ChatStore)
