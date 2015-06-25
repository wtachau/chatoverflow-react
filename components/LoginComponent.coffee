React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h3, button } = React.DOM

LoginComponent = React.createClass

  propTypes:
    loginClicked: React.PropTypes.func.isRequired
    
  render: ->
    Row {},
      Col md: 6, mdOffset: 3,
        div {className:"login-button", onClick: @props.loginClicked},
          Button {}, "Login"
        div className:{},
          h1 className: "center-block" , "Chat Overflow"
        div className:{},
          h3 className: "subtitle", "Neque porro quisquam est qui dolorem ipsum"
        div {className:"register-button", onClick: @props.loginClicked},
          Button bsSize: 'large', "Register"

module.exports = LoginComponent
