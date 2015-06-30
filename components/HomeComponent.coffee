React = require("react")

{ h1 } = React.DOM

HomeComponent = React.createClass
  displayName: "HomeComponent"

  render: ->
    h1 {}, "welcome!"

module.exports = HomeComponent