React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h3, button, i } = React.DOM

LoginComponent = React.createClass
  displayName: "LoginComponent"

  propTypes:
    loginClicked: React.PropTypes.func.isRequired

  render: ->
    Row {},
      Col md: 6, mdOffset: 3,
        div className:{},
          h1 className: "center-block" , "chatsignal"
        div className:{},
          h3 className: "subtitle",
            i {}, "to the chat mobile!"
        div {className:"register-button", onClick: @props.loginClicked},
          Button bsSize: 'large', "login"

module.exports = LoginComponent
