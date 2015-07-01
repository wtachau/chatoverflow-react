React = require("react")
Mark = require "react-marked"
ReactBootstrap = require "react-bootstrap"
{ div, h1 } = React.DOM
HomeComponent = React.createClass
  displayName: "HomeComponent"

  render: ->
    div {}, Marked.marked("welcome!")

module.exports = HomeComponent
