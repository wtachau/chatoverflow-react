React = require("react")

ReactBootstrap = require "react-bootstrap"
{ div, h1 } = React.DOM
HomeComponent = React.createClass
  displayName: "HomeComponent"

  render: ->
    div {}, ("Welcome!")

module.exports = HomeComponent
