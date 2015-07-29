React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h2, h3, i } = React.DOM

MainLandingComponent = React.createClass
  displayName: "MainLandingComponent"

  propTypes:
    onLoginClick: React.PropTypes.func.isRequired

  render: ->
    div {className: "container main"},
      Row {},
        Col md: 1,
          h2 {}, "chatsignal"
        Col md: 3, mdOffset: 8,
          div {onClick: @props.onLoginClick},
            Button {bsSize: 'large'},
              i {className: "fa fa-github github-icon"}
              "Login with GitHub"
      Row {className: "blank"}
      Row {},
        Col md: 12,
          h1 {}, "Learn and help as fast as you type."
          h3 {}, "Chatsignal is Slack x StackOverflow and a few more things you
            should know about."
      Row {},
        Col md: 6,
          Button {bsSize: 'large'}, "Start Chatting"
          Button {bsSize: 'large'}, "Learn More"

module.exports = MainLandingComponent
