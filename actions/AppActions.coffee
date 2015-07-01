alt = require("../alt")
URLResources = require("../common/URLResources")

class AppActions
  constructor: ->
    @generateActions "setCurrentUser", "userFetchFailure"

  fetchUser: ->
    URLResources.readFromAPI "/current_user", @actions.setCurrentUser, @actions.userFetchFailure

  login: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/login")

  logout: ->
    @actions.setCurrentUser null
    sessionStorage.setItem("jwt", "")

module.exports = alt.createActions(AppActions)
