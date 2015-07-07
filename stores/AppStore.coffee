alt = require("../alt")
AppActions = require("../actions/AppActions")

class AppStore
  displayName: 'AppStore'

  constructor: () ->
    @user = null
    @users = null
    @error = null
    @unread_mentions = {}

    @bindActions(AppActions)

  onSetCurrentUser: (user) ->
    @user = user

  onSetCurrentUsers: (users) ->
    @users = users

  onSetUnreadMentions: (unread_mentions) ->
    @unread_mentions = unread_mentions

  onFailure: (error) ->
    @error = error

module.exports = alt.createStore(AppStore, 'AppStore')
