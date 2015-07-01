alt = require("../alt")
ChatActions = require("../actions/ChatActions")

class ChatStore
  displayName: "ChatStore"
  
  constructor: ->
    @currentMessage = ""
    @messages = []
    @topics = []
    @topicInfo = null

    @bindActions(ChatActions)

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicInfo: (topicInfo) ->
    @topicInfo = topicInfo

module.exports = alt.createStore(ChatStore)
