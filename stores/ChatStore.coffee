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
    @oldestPage = null
    @currentRoom = null
    @keyPressMap = []

    @bindActions(ChatActions)

  onSetCurrentQuestion: (question) ->
    @currentQuestion = question

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

  onPrependToMessages: (messages) ->
    @messages = messages.concat(@messages)

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicSelected: (topicSelected) ->
    @topicSelected = topicSelected

  onSetTopicInfo: (topicInfo) ->
    @topicInfo = topicInfo

  onSetMentions: (mentions) ->
    @mentions = mentions

  onSetOldestPage: (page) ->
    @oldestPage = page

module.exports = alt.createStore(ChatStore)
