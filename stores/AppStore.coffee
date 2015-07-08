alt = require("../alt")
AppActions = require("../actions/AppActions")

class AppStore
  displayName: 'AppStore'

  constructor: () ->
    @user = null
    @users = null
    @error = null
    @unread_mentions = {}
    @showUserPopup = false

    @bindActions(AppActions)

  onSetCurrentUser: (user) ->
    @user = user

  onSetCurrentUsers: (users) ->
    @users = users

  onSetUnreadMentions: (room_id) ->
    @unread_mentions[parseInt(room_id)] = true

  onSetReadMentions: (room_id) ->
    @unread_mentions[parseInt(room_id)] = false

  onShowUserPopup: (value) ->
    @showUserPopup = value

  onFailure: (error) ->
    @error = error

module.exports = alt.createStore(AppStore, 'AppStore')
