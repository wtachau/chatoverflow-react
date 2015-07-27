alt = require("../alt")
URLResources = require("../common/URLResources")

class RoomActions
  constructor: ->
    @generateActions "setTopics",
      "setTopicSelected", "setTopicInfo",
      "setSearchResults", "setFollowedTopics", "setIntervalID"

  fetchTopicInfo: (topic_id) ->
    URLResources.readFromAPI "/topics/#{topic_id}", @actions.setTopicInfo

  fetchTopics: ->
    URLResources.readFromAPI "/topics", @actions.setTopics

  fetchSearchResults: (query) ->
    URLResources.readFromAPI "/topics/search/#{query}", @actions.setSearchResults

  fetchFailure: (error) ->
    console.error(error)

  fetchFollowedTopics: ->
    URLResources.readFromAPI "/users/followed_topics",
      @actions.setFollowedTopics

module.exports = alt.createActions(RoomActions)
