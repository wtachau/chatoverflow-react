alt = require("../alt")
URLResources = require("../common/URLResources")

class AppActions
  constructor: ->
    @generateActions "setCurrentUser", "userFetchFailure",
      "setCurrentUsers", "setUnreadMentions", "setReadMentions", "failure"

  fetchUser: ->
    URLResources.readFromAPI "/current_user", @actions.setCurrentUser

  fetchUsers: ->
    URLResources.readFromAPI "/users", @actions.setCurrentUsers

  followRoom: (room_id, alreadyFollowing) ->
    unless alreadyFollowing room_id
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "put", null, @actions.setCurrentUser
    else
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "delete", null, @actions.setCurrentUser

  followTopic: (room_id, alreadyFollowing) ->
    unless alreadyFollowing room_id
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "put", null, @actions.setCurrentUser
    else
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "delete", null, @actions.setCurrentUser

  login: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/login")

  logout: ->
    @actions.setCurrentUser null
    sessionStorage.setItem("jwt", "")

module.exports = alt.createActions(AppActions)
