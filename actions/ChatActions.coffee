alt = require("../alt")
URLResources = require("../common/URLResources")
AppActions = require("./AppActions")

class ChatActions
  constructor: ->
    @generateActions "setCurrentMessage", "setMessagesList",
      "setTopics", "setCurrentQuestion", "setTopicSelected",
      "setTopicInfo", "setMentions", "setMessage", "setCurrentPage",
      "addToMessages"

  fetchRoomHistory: (roomId, page) ->
    if page
      URLResources.readFromAPI "/rooms/#{roomId}/messages?page=#{page}",
        @actions.fetchPreviousMessagesSuccess
    else
      URLResources.readFromAPI "/rooms/#{roomId}/messages",
        @actions.fetchRoomHistorySuccess

  fetchPreviousMessagesSuccess: (response) ->
    console.log response.messages
    console.log "----"
    console.log response.page
    @actions.addToMessages response.messages
    @actions.setCurrentPage response.page

  fetchRoomHistorySuccess: (response) ->
    @actions.setMessagesList response.messages
    @actions.setCurrentPage response.page

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
