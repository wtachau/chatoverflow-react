alt = require("../alt")
URLResources = require("../common/URLResources")

class ChatActions
  constructor: ->
    @generateActions('setCurrentMessage', 'setMessagesList', 'setTopics')

  fetchRoomHistory: (roomId) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages", @actions.fetchRoomHistorySuccess, @actions.fetchFailure

  fetchRoomHistorySuccess: (response) ->
    messages = response.map ({username, text}) -> {username, text}
    @actions.setMessagesList messages

  fetchFailure: (error) ->
    console.error(error)

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics, @actions.fetchFailure

module.exports = alt.createActions(ChatActions)
