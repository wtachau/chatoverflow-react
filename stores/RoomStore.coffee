alt         = require("../alt")
RoomActions = require("../actions/RoomActions")

class RoomStore
  displayName: "RoomStore"

  constructor: ->
    @topics = []
    @topicSelected = null
    @topicInfo = null
    @searchResults = []
    @followedTopics = []
    @followedTopicsRooms = []
    @intervalID = -1

    @bindActions(RoomActions)

  onSetIntervalID: (intervalID) ->
    @intervalID = intervalID

  onSetCurrentRoom: (room) ->
    @currentRoom = room

  onSetSearchResults: (results) ->
    @searchResults = results

  onSetTopics: (topics) ->
    @topics = topics

  onSetTopicSelected: (topicSelected) ->
    @topicSelected = topicSelected
    
  onSetTopicInfo: (topicInfo) ->
    @topicInfo = topicInfo

  onSetFollowedTopics: (followedTopics) ->
    @followedTopics = followedTopics
    @followedTopicsRooms = []
    for topic in @followedTopics
      for room in topic.rooms
        room['topic_title'] = topic.name
        @followedTopicsRooms.push room

module.exports = alt.createStore(RoomStore)
