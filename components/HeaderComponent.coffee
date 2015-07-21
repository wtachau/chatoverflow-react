React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
UserComponent = React.createFactory require("./UserComponent")
Navbar = React.createFactory(ReactBootstrap.Navbar)
Nav = React.createFactory(ReactBootstrap.Nav)
Link = React.createFactory Router.Link
{ div, h3 } = React.DOM

HeaderComponent = React.createClass
  displayName: "HeaderComponent"

  render: ->
    Navbar {},
      Nav {},
        Link to: "app",
          h3 {className: "chatsignal-logo"}, "chatsignal"
      Nav {},
        Link to: "ask",
          div {className: "newthread"}, "+ New Thread"
        UserComponent
          user: @props.user
          includeLogout: true

module.exports = HeaderComponent