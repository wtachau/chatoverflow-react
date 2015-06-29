React = require("react")

{ h1 } = React.DOM

HomePageComponent = React.createClass

  render: ->
    h1 {}, "welcome!"

module.exports = HomePageComponent