alt = require("../alt")
AppActions = require("../actions/AppActions")

class AppStore
  displayName: 'AppStore'

  constructor: () ->
    @user = null
    @error = null

    @bindActions(AppActions)

  onSetCurrentUser: (user) ->
    @user = user

  onUserFetchFailure: (error) ->
    @error = error

module.exports = alt.createStore(AppStore, 'AppStore')
