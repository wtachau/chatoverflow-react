React                = require("react")
MessageResources     = require("../../common/MessageResources")
UserStore            = require("../../stores/UserStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
ReactBootstrap       = require("react-bootstrap")

Message       = React.createFactory require("./Message")
UserComponent = React.createFactory require("../UserComponent")
Row           = React.createFactory ReactBootstrap.Row
Col           = React.createFactory ReactBootstrap.Col

{ div, img } = React.DOM

MessageGroupList = React.createClass
  displayName: "MessageGroupList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: UserStore

  propTypes:
    messageGroups: React.PropTypes.array.isRequired

  render: ->
    div {},
      @props.messageGroups.map (group, index) =>
        properties = MessageResources.getMessageProperties group, @state.user
        side = if group[0].user.username is @state.user.username then "right" else "left"
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
                    votes: @state.user.votes
                    key: index
                    bubbleType: properties[index].bubbleType
                    side: properties[index].side
                    isUser: properties[index].isUser
                    isFirst: index is 0

module.exports = MessageGroupList
