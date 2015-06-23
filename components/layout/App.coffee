React = require "react"
LoginComponent = require("../LoginComponent.coffee")
ChatComponent = require("../ChatComponent.coffee")

module.exports = React.createClass
  getInitialState: ->
    {isLoggedIn: false}

  loginClicked: ->
    @setState isLoggedIn: true

  render: -> 
    if @state.isLoggedIn 
      React.createElement ChatComponent
    else
      React.createElement LoginComponent, loginClicked: @loginClicked

