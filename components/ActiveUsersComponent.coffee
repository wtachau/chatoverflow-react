React                = require("react")
ReactBootstrap       = require("react-bootstrap")
RoomStore            = require("../stores/RoomStore")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

UserComponent = React.createFactory require("./UserComponent")
ListGroup     = React.createFactory ReactBootstrap.ListGroup

{ div, h1, img } = React.DOM

Row = React.createFactory ReactBootstrap.Row


ActiveUsersComponent = React.createClass
  displayName: "ActiveUsersComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: RoomStore

  render: ->
    div {className: "active-users"},
      @state.topicInfo?.followers.map (user, index) ->
        div {className: "active-user", key: index},
          UserComponent {user}
          div {className: "user-details"},
            div {className: "active-user-name"}, user.name
            div {className: "active-user-username"}, user.username

module.exports = ActiveUsersComponent

