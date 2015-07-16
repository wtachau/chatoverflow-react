FollowResources =

  isFollowingRoom: (room_id, user) ->
    console.log user
    followedRoomIds = user.followed_rooms.map ({id}) -> id
    parseInt(room_id) in followedRoomIds

  isFollowingTopic: (topic_id, user) ->
    followedTopicIds = user.followed_topics.map ({id}) -> id
    parseInt(topic_id) in followedTopicIds

module.exports = FollowResources
