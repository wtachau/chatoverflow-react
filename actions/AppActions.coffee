alt = require("../alt")
URLResources = require("../common/URLResources")

class AppActions
  constructor: ->
    @generateActions "setCurrentUser", "userFetchFailure",
      "setCurrentUsers", "failure"

  fetchUser: ->
    URLResources.readFromAPI "/current_user", @actions.setCurrentUser

  fetchUsers: ->
    URLResources.readFromAPI "/users", @actions.setCurrentUsers

  followRoom: (roomId, alreadyFollowing) ->
    unless alreadyFollowing roomId
      URLResources.callAPI "/users/follow/#{roomId}",
        "put", null, @actions.setCurrentUser
    else
      URLResources.callAPI "/users/follow/#{roomId}",
        "delete", null, @actions.setCurrentUser

  login: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/login")

  logout: ->
    @actions.setCurrentUser null
    sessionStorage.setItem("jwt", "")

module.exports = alt.createActions(AppActions)
