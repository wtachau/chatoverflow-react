alt = require("../alt")
AppActions = require("../actions/AppActions")

class AppStore
  displayName: 'AppStore'

  constructor: () ->
    @user = {}
    @users = []
    @error = null
    @unread_mentions = {}

    @bindActions(AppActions)

  onSetCurrentUser: (user) ->
    @user = user

  onSetCurrentUsers: (users) ->
    @users = users

  onSetUnreadMentions: (room_id) ->
    @unread_mentions[parseInt(room_id)] = true

  onSetReadMentions: (room_id) ->
    @unread_mentions[parseInt(room_id)] = false

  onFailure: (error) ->
    @error = error

module.exports = alt.createStore(AppStore, 'AppStore')
