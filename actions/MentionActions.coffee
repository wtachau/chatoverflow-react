alt             = require("../alt")
URLResources    = require("../common/URLResources")
FollowResources = require("../common/FollowResources")

class MentionActions
  constructor: ->
    @generateActions "setUnreadMentions", "setReadMentions"

module.exports = alt.createActions(MentionActions)
