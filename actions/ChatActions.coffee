alt = require("../alt")
URLResources = require("../common/URLResources")
AppActions = require("./AppActions")

class ChatActions
  constructor: ->
    @generateActions "setCurrentMessage", "setMessagesList",
      "setTopics", "setCurrentQuestion", "setTopicSelected",
      "setTopicInfo", "setMentions"

  fetchRoomHistory: (roomId) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages",
      @actions.fetchRoomHistorySuccess

  fetchRoomHistorySuccess: (response) ->
    messages = response.map ({username, text}) -> {username, text}
    @actions.setMessagesList messages

  fetchTopicInfo: (currentTopic) ->
    URLResources.readFromAPI "/topics/#{currentTopic}", @actions.setTopicInfo

  fetchFailure: (error) ->
    console.error(error)

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics

module.exports = alt.createActions(ChatActions)
