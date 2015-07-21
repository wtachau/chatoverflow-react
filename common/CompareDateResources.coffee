Reqwest = require("reqwest")
AppActions = require ("../actions/AppActions")

CompareDateResources =
  compareDateCreatedAt: (room1, room2) ->
    room1 = new Date room1.created_at
    room2 = new Date room2.created_at
    if room1 > room2 
      -1 
    else 
      if room1 < room2 
        1 
      else 
        0

  compareLatestMessage: (room1, room2) -> 
    room1 = new Date room1.messages[room1.messages.length - 1]?.created_at
    room2 = new Date room2.messages[room2.messages.length - 1]?.created_at
    if room1 > room2 
      -1 
    else 
      if room1 < room2 
        1 
      else 
        0

module.exports = CompareDateResources
