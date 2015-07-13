React = require("react")

Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ div } = React.DOM

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

  renderMessage: (group) ->
    group.map (message, index) =>
      if message.user.username is @state.app.user.username
        side = "right"
        bubbleType = @selectBubbleType index, group.length
      else
        side = "left"
        bubbleType = @selectBubbleType index, group.length
      Message { message, key: index, bubbleType, side }

  render: ->
    div {},
      @props.messageGroups.map (group, index) =>
        @renderMessage group

module.exports = MessageGroupList
