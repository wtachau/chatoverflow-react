alt             = require("../alt")
URLResources    = require("../common/URLResources")
FollowResources = require("../common/FollowResources")

class UserActions
  constructor: ->
    @generateActions "setCurrentUser", "userFetchFailure",
      "setCurrentUsers", "pushUserVote", "removeUserVote"

  fetchUser: ->
    URLResources.readFromAPI "/current_user", @actions.setCurrentUser

  fetchUsers: ->
    URLResources.readFromAPI "/users", @actions.setCurrentUsers

  followRoom: (room_id, user) ->
    unless FollowResources.isFollowingRoom room_id, user
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "put", null, @actions.setCurrentUser
    else
      URLResources.callAPI "/rooms/#{room_id}/follow",
        "delete", null, @actions.setCurrentUser

  followTopic: (topic_id, user) ->
    unless FollowResources.isFollowingTopic topic_id, user
      URLResources.callAPI "/topics/#{topic_id}/follow",
        "put", null, @actions.setCurrentUser
    else
      URLResources.callAPI "/topics/#{topic_id}/follow",
        "delete", null, @actions.setCurrentUser

  createTopic: (name, callback) ->
    URLResources.callAPI "/topics", "post", {name}, callback

  githubLogin: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/github_login")

  twitterLogin: ->
    window.location.assign("#{ URLResources.getLogicServerOrigin() }/twitter_login")

  logout: ->
    @actions.setCurrentUser null
    sessionStorage.setItem("jwt", "")

module.exports = alt.createActions(UserActions)
