MessageResources =

  createGroups: (rest) ->
  # groups messages together by username
    messageGroups = []
    group = []
    rest.map (message, index) =>
      if index isnt 0 and rest[index-1].user.username isnt message.user.username
        messageGroups.push group
        group = []
      group.push message
    unless group.length is 0
      messageGroups.push group
    messageGroups

  selectBubbleType: (index, length) ->
    if length is 1
      "single-bubble"
    else if index is 0
      "top-bubble"
    else if index is length - 1
      "bottom-bubble"
    else
      "middle-bubble"

  getMessageProperties: (group, user) ->
    group.map (message, index) =>
      properties = {}
      if message.user.username is user.username
        properties.isUser = true
        properties.side = "right"
        properties.bubbleType = @selectBubbleType index, group.length
      else
        properties.isUser = false
        properties.side = "left"
        properties.bubbleType = @selectBubbleType index, group.length
      properties

module.exports = MessageResources
