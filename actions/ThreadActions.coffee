alt          = require("../alt")
URLResources = require("../common/URLResources")
$            = require("jquery")

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

  openPanel: ->
    $(".home").removeClass("ask-position-left").addClass("ask-position-right")
    $(".sidebar").removeClass("position-left").addClass("position-right")
    $(".new-thread").html("Cancel").addClass("cancel-color")

  closePanel: ->
    $(".home").removeClass("ask-position-right").addClass("ask-position-left")
    $(".sidebar").removeClass("position-right").addClass("position-left")
    $(".new-thread").removeClass("cancel-color").html("New Thread").append('<i class="fa fa-plus"></i>')

  fetchFailure: (error) ->
    console.error(error)

module.exports = alt.createActions(ThreadActions)
