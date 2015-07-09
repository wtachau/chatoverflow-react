React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
Navbar = React.createFactory(ReactBootstrap.Navbar)
Nav = React.createFactory(ReactBootstrap.Nav)
Link = React.createFactory Router.Link
{ h3 } = React.DOM

HeaderComponent = React.createClass
  displayName: "HeaderComponent"

  render: ->
    Navbar {},
      Nav {},
        Link to: "app",
          h3 {}, "chatsignal"

module.exports = HeaderComponent
