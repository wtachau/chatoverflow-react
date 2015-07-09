alt = require("../alt")
URLResources = require("../common/URLResources")
AppActions = require("./AppActions")

class ChatActions
  constructor: ->
    @generateActions "setCurrentMessage", "setMessagesList",
      "setTopics", "setCurrentQuestionTitle", "setCurrentQuestionText",
      "setTopicSelected", "setTopicInfo", "setMentions", "setMessage",
      "setCurrentRoom"

  fetchRoomHistory: (room_id) ->
    URLResources.readFromAPI "/rooms/#{room_id}", @actions.setCurrentRoom

  fetchTopicInfo: (topic_id) ->
    URLResources.readFromAPI "/topics/#{topic_id}", @actions.setTopicInfo

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics

  upvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/upvote",
      "PUT", null, @actions.setMessage

  downvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/downvote",
      "PUT", null, @actions.setMessage

  fetchFailure: (error) ->
    console.error(error)


module.exports = alt.createActions(ChatActions)
