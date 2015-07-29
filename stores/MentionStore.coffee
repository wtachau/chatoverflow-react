alt            = require("../alt")
MentionActions = require("../actions/MentionActions")

class MentionStore
  displayName: 'MentionStore'

  constructor: () ->
    @unread = {}
    @bindActions(MentionActions)

  onSetUnreadMentions: (room_id) ->
    @unread[parseInt(room_id)] = true

  onSetReadMentions: (room_id) ->
    @unread[parseInt(room_id)] = false

module.exports = alt.createStore(MentionStore, 'MentionStore')
