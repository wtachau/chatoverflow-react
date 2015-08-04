alt          = require("../alt")
URLResources = require("../common/URLResources")

class ThreadActions
  constructor: ->
    @generateActions "setMessagesList",
      "setMessage", "setCurrentRoom", "setOldestPage",
      "prependToMessages", "setOriginalPost",
      "setRecentMessages", "pushNewMessage"

  fetchRecentMessages: (roomId) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages",
      @actions.setRecentMessages

  fetchOldMessages: (roomId, page) ->
    URLResources.readFromAPI "/rooms/#{roomId}/messages?page=#{page}",
      @actions.fetchOldMessagesSuccess

  fetchOldMessagesSuccess: (response) ->
    @actions.prependToMessages response.messages
    @actions.setOldestPage response.page

  starMessage: (id, room_id) ->
    URLResources.callAPI "/rooms/#{room_id}/messages/#{id}/vote",
      "PUT", null, @actions.setMessage

  fetchFailure: (error) ->
    console.error(error)

module.exports = alt.createActions(ThreadActions)
