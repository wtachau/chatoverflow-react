alt = require("../alt")
ChatActions = require("../actions/ChatActions")

class ChatStore
  displayName: 'ChatStore'
  
  constructor: ->
    @currentMessage = ""
    @messages = []
    @topics = []

    @bindActions(ChatActions)

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onSetTopics: (topics) ->
    @topics = topics

  onSetMentions: (mentions) ->
    @mentions = mentions

module.exports = alt.createStore(ChatStore)