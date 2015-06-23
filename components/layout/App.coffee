React = require "react"
{ div, h1, h3, button} = React.DOM

module.exports = React.createClass
  render: -> 
    div {className:"col-md-offset-3 col-md-6"},
      div className:"login-button",
        button className: "btn btn-default", "Login"
      div className:{},
        h1 className: "center-block" , "Chat Overflow"
      div className:{},
        h3 className: "subtitle", "Neque porro quisquam est qui dolorem ipsum "
      div className:"register-button",
        button  className:"btn btn-default btn-lg" , "Register"

