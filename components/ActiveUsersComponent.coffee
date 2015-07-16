React = require("react")
ReactBootstrap = require("react-bootstrap")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
ChatStore = require("../stores/ChatStore")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
{ div, h1, img} = React.DOM

Row = React.createFactory ReactBootstrap.Row

ActiveUsersComponent = React.createClass
  displayName: "ActiveUsersComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: ChatStore

  render: ->
    div {className: "active-users"},
      Row {className: "active-users-header"},
        h1 {className: "current-topic"}, "Active Users"
      ListGroup {},
        @state.topicInfo?.followers.map ({username, pic_url}, index) ->
          ListGroupItem {className: "active-user", key: index},
            img {src: pic_url, className: "profile-pic"},
            div {className: "active-user-username"}, username

module.exports = ActiveUsersComponent

