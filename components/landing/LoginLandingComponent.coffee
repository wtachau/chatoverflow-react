React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h3, i } = React.DOM

LoginLandingComponent = React.createClass
  displayName: "LoginLandingComponent"

  propTypes:
    onLoginClick: React.PropTypes.func.isRequired

  render: ->
    div {className: "container bottom-login"},
      Row {},
        Col md: 12,
          h3 {}, "Ready to be part of the conversation?"
        Col md: 12,
          div {className:"register-button", onClick: @props.onLoginClick},
            Button bsSize: 'large',
              i {className: "fa fa-github"}
              div {className: "login-text"}, "Login with GitHub"

module.exports = LoginLandingComponent
