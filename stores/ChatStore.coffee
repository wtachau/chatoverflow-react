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

module.exports = alt.createStore(ChatStore)
