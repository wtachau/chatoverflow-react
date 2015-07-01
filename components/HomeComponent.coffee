React = require("react")

{ div } = React.DOM
HomeComponent = React.createClass
  displayName: "HomeComponent"

  render: ->
    div {}, ("Welcome!")

module.exports = HomeComponent
