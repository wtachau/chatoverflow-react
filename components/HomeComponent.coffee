React = require("react")

{ div, h1 } = React.DOM
HomeComponent = React.createClass
  displayName: "HomeComponent"

  render: ->
    div {}, ("Welcome!")

module.exports = HomeComponent
