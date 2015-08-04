alt           = require("../alt")
ThreadActions = require("../actions/ThreadActions")

class ThreadStore
  displayName: "ThreadStore"

  constructor: ->
    @messages = []
    @oldestPage = null
    @originalPost = null
    @currentRoom = null
    @isFinishedLoadingMessages = true
    @startNewThread = null

    @bindActions(ThreadActions)

  onSetMessage: (message) ->
    for m, i in @messages
      if m.id is message.id
        @messages[i] = message

  onSetMessagesList: (messages) ->
    @messages = messages

  onPushNewMessage: (message) ->
    @messages.push message

  onSetRecentMessages: (response) ->
    @isFinishedLoadingMessages = true
    @originalPost =  response.originalPost
    @messages = response.messages
    @oldestPage = response.page

  onPrependToMessages: (messages) ->
    unless messages.length is 0
      @messages = messages.concat @messages
      @isFinishedLoadingMessages = false
    else
      @isFinishedLoadingMessages = true

  onSetOldestPage: (page) ->
    @oldestPage = page

  onSetOriginalPost: (post) ->
    @originalPost = post

  onSetCurrentRoom: (room) ->
    @currentRoom = room

module.exports = alt.createStore(ThreadStore)
