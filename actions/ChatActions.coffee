alt = require("../alt")
URLResources = require("../common/URLResources")
AppActions = require("./AppActions")

class ChatActions
  constructor: ->
    @generateActions "setCurrentMessage", "setMessagesList",
      "setTopics", "setCurrentQuestionTitle", "setCurrentQuestionText",
      "setTopicSelected", "setTopicInfo", "setMentions", "setMessage"

  fetchRoomHistory: (roomId) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages",
      @actions.fetchRoomHistorySuccess

  fetchRoomHistorySuccess: (response) ->
    @actions.setMessagesList response

  fetchTopicInfo: (currentTopic) ->
    URLResources.readFromAPI "/topics/#{currentTopic}", @actions.setTopicInfo

  fetchFailure: (error) ->
    console.error(error)

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics

  upvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/upvote",
      "PUT", null, @actions.setMessage

  downvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/downvote",
      "PUT", null, @actions.setMessage


module.exports = alt.createActions(ChatActions)
