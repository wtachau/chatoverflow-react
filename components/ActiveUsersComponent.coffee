React = require("react")
ReactBootstrap = require("react-bootstrap")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
ChatStore = require("../stores/ChatStore")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
UserComponent = React.createFactory require("./UserComponent")
{ div, h1, ul, li, img} = React.DOM

ActiveUsersComponent = React.createClass
  displayName: "ActiveUsersComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  render: ->
    div {className: "active-users"},
      h1 {className: "active-users-header"}, "Active Users"
      ListGroup {},
        @state.topicInfo?.followers.map (user, index) ->
          ListGroupItem {className: "active-user", key: index},
            UserComponent {user}
            div {className: "active-user-username"}, user.username

module.exports = ActiveUsersComponent

