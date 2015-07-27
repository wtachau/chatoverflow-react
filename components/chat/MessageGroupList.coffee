React = require("react")

Message = React.createFactory require("./Message")
UserComponent = React.createFactory require("../UserComponent")
UserStore = require("../../stores/UserStore")
UserActions = require("../../actions/UserActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ReactBootstrap = require("react-bootstrap")

{ div, img } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col

MessageGroupList = React.createClass
  displayName: "MessageGroupList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      chat: ChatStore

  propTypes:
    messageGroups: React.PropTypes.array.isRequired

  selectBubbleType: (index, length) ->
    if length is 1
      "single-bubble"
    else if index is 0
      "top-bubble"
    else if index is length - 1
      "bottom-bubble"
    else
      "middle-bubble"

  getMessageProperties: (group) ->
    group.map (message, index) =>
      properties = {}
      if message.user.username is @state.user.user.username
        properties.isUser = true
        properties.side = "right"
        properties.bubbleType = @selectBubbleType index, group.length
      else
        properties.isUser = false
        properties.side = "left"
        properties.bubbleType = @selectBubbleType index, group.length
      properties

  render: ->
    div {},
      @props.messageGroups.map (group, index) =>
        properties = @getMessageProperties group
        side = if group[0].user.username is @state.user.user.username then "right" else "left"
        Row {className: "message-group #{side} row-no-margin", key: index},
          Col md: 1,
            if side is "left"
              UserComponent {user: group[0].user}
          Col md: 11,
            if side is "left"
              Row {className: "username row-no-margin"},
                group[0].user.username
            Row {className: "row-no-margin"},
              group.map (message, index) =>
                div {className: "message", key: index},
                  Message
                    message: message
                    votes: @state.user.user.votes
                    key: index
                    bubbleType: properties[index].bubbleType
                    side: properties[index].side
                    isUser: properties[index].isUser
                    isFirst: index is 0

module.exports = MessageGroupList
