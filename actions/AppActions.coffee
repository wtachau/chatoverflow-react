alt = require("../alt")
URLResources = require("../common/URLResources")

class AppActions
  constructor: ->
    @generateActions 'setCurrentUser', 'setCurrentUsers', 'failure'

  fetchUser: ->
    URLResources.readFromAPI "/current_user", @actions.setCurrentUser, @actions.failure

  fetchUsers: ->
    URLResources.readFromAPI "/users", @actions.setCurrentUsers, @actions.failure

  login: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/login")

  logout: ->
    @actions.setCurrentUser null
    sessionStorage.setItem('jwt', '')

module.exports = alt.createActions(AppActions)
