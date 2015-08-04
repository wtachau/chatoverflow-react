React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h3, i } = React.DOM

LoginLandingComponent = React.createClass
  displayName: "LoginLandingComponent"

  propTypes:
    onGithubLoginClick: React.PropTypes.func.isRequired
    onTwitterLoginClick: React.PropTypes.func.isRequired

  render: ->
    div {className: "container bottom-login"},
      Row {},
        Col md: 12,
          h3 {}, "Ready to be part of the conversation?"
        Col md: 12,
          div {className:"register-button", onClick: @props.onGithubLoginClick},
            Button bsSize: 'large',
              i {className: "fa fa-github"}
              div {className: "login-text"}, "Login with GitHub"
          div {className:"register-button", onClick: @props.onTwitterLoginClick},
            Button bsSize: 'large',
              i {className: "fa fa-twitter"}
              div {className: "login-text"}, "Login with Twitter"

module.exports = LoginLandingComponent
