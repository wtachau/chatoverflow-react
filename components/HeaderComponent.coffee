React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
Navbar = React.createFactory(ReactBootstrap.Navbar)
Nav = React.createFactory(ReactBootstrap.Nav)
Link = React.createFactory Router.Link
UserComponent = React.createFactory require("./UserComponent")
{ h3 } = React.DOM

HeaderComponent = React.createClass
  displayName: "HeaderComponent"

  render: ->
    Navbar {},
      Nav {},
        Link to: "/",
          h3 {}, "chatsignal"
        UserComponent {}

module.exports = HeaderComponent
