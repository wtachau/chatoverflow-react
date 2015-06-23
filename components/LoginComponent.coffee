React = require "react"
{ div, h1, h3, button} = React.DOM

LoginComponent = React.createClass
    
  render: ->
    div {className:"col-md-offset-3 col-md-6"},
      div {className:"login-button", onClick: @props.loginClicked},
        button className: "btn btn-default", "Login"
      div className:{},
        h1 className: "center-block" , "Chat Overflow"
      div className:{},
        h3 className: "subtitle", "Neque porro quisquam est qui dolorem ipsum"
      div {className:"register-button", onClick: @props.loginClicked},
        button  className:"btn btn-default btn-lg" , "Register"

module.exports = LoginComponent
