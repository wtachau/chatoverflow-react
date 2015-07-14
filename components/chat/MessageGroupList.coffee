React = require("react")

Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ReactBootstrap = require("react-bootstrap")

{ div, img } = React.DOM

Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col

MessageGroupList = React.createClass
  displayName: "MessageGroup"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  propTypes:
    messageGroups: React.PropTypes.array.isRequired

  selectBubbleType: (index, length) ->
    bubbleType =  if length is 1
                    "single-bubble"
                  else if index is 0
                    "top-bubble"
                  else if index is length - 1
                    "bottom-bubble"
                  else
                    "middle-bubble"
    bubbleType

  getMessageProperties: (group) ->
    group.map (message, index) =>
      if message.user.username is @state.app.user.username
        isUser = true
        side = "right"
        bubbleType = @selectBubbleType index, group.length
      else
        isUser = false
        side = "left"
        bubbleType = @selectBubbleType index, group.length
      Message { message, key: index, bubbleType, side, isUser }

  render: ->
    div {},
      @props.messageGroups.map (group, index) =>
        isUser = if group[0].user.username is @state.app.user.username then "right" else "left"
        div {className: "message-group #{isUser}"},
          Row {className: "no-margin margin-top"},
            div {},
              Col md: 1,
                img {className: "profile-pic", src: group[0].user.pic_url}
              Col md: 8,
                div {}, group[0].user.username
          Col md: 11, mdOffset: 1,
            @getMessageProperties group

module.exports = MessageGroupList
