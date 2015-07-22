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
    @oldestPage = null
    @originalPost = null
    @currentRoom = null
    @searchResults = []
    @keyPressMap = []
    @autoScrollWindow = 160
    @isFinishedLoadingMessages = true
    @startNewThread = null
    @followedTopics = []
    @followedTopicsRooms = []

    @bindActions(ChatActions)

  onSetCurrentQuestionTitle: (questionTitle) ->
    @currentQuestionTitle = questionTitle

  onSetCurrentQuestionText: (questionText) ->
    @currentQuestionText = questionText

  onSetCurrentMessage: (message) ->
    @currentMessage = message

  onSetCurrentRoom: (room) ->
    @currentRoom = room

  onSetSearchResults: (results) ->
    @searchResults = results

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

  onSetOriginalPost: (post) ->
    @originalPost = post

  onSetFollowedTopics: (followedTopics) ->
    @followedTopics = followedTopics
    @followedTopicsRooms = []
    for topic in @followedTopics
      for room in topic.rooms
        room['topic_title'] = topic.name
        @followedTopicsRooms.push room

module.exports = alt.createStore(ChatStore)
