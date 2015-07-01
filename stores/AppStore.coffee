alt = require("../alt")
AppActions = require("../actions/AppActions")

class AppStore
  displayName: 'AppStore'

  constructor: () ->
    @user = null
    @users = null
    @error = null

    @bindActions(AppActions)

  onSetCurrentUser: (user) ->
    @user = user

  onSetCurrentUsers: (users) ->
    @users = users

  onFailure: (error) ->
    @error = error

module.exports = alt.createStore(AppStore, 'AppStore')
