alt = require("../alt")
URLResources = require("../common/URLResources")
AppActions = require("./AppActions")

class ChatActions
  constructor: ->
    @generateActions "setCurrentMessage", "setMessagesList",
      "setTopics", "setCurrentQuestionTitle", "setCurrentQuestionText",
      "setTopicSelected", "setTopicInfo", "setMentions", "setMessage",
      "setCurrentRoom", "setOldestPage", "prependToMessages",
      "setSearchResults"

  fetchRecentMessages: (roomId) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages",
      @actions.fetchRecentMessagesSuccess

  fetchRecentMessagesSuccess: (response) ->
    @actions.setMessagesList response.messages
    @actions.setOldestPage response.page

  fetchOldMessages: (roomId, page) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages?page=#{page}",
      @actions.fetchOldMessagesSuccess

  fetchOldMessagesSuccess: (response) ->
    @actions.prependToMessages response.messages
    @actions.setOldestPage response.page

  fetchTopicInfo: (topic_id) ->
    URLResources.readFromAPI "/topics/#{topic_id}", @actions.setTopicInfo

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics

  fetchSearchResults: (query, callback = @actions.setSearchResults) ->
    URLResources.readFromAPI "/topics/search/#{query}", callback

  upvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/upvote",
      "PUT", null, @actions.setMessage

  downvoteMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/downvote",
      "PUT", null, @actions.setMessage

  fetchFailure: (error) ->
    console.error(error)


module.exports = alt.createActions(ChatActions)
