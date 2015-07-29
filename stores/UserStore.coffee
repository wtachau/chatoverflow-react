alt         = require("../alt")
UserActions = require("../actions/UserActions")

class UserStore
  displayName: 'UserStore'

  constructor: () ->
    @user = null
    @users = []

    @bindActions(UserActions)

  onPushUserVote: (vote) ->
    @user.votes.push vote

  onRemoveUserVote: (index) ->
    @user.votes.splice(index, 1)

  onSetCurrentUser: (user) ->
    @user = user

  onSetCurrentUsers: (users) ->
    @users = users

module.exports = alt.createStore(UserStore, 'UserStore')
