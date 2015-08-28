React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h2, h3, i, img } = React.DOM

MainLandingComponent = React.createClass
  displayName: "MainLandingComponent"

  propTypes:
    onGithubLoginClick: React.PropTypes.func.isRequired
    onTwitterLoginClick: React.PropTypes.func.isRequired

  render: ->
    logo = "../assets/images/cs-logo-letter.png"
    div {className: "container main"},
      Row {},
        Col md: 1,
          h2 {}, " "
        Col md: 3, mdOffset: 8,
          div {onClick: @props.onGithubLoginClick},
            Button {bsSize: 'large'},
              i {className: "fa fa-github github-icon"}
              "Login with GitHub"
          div {onClick: @props.onTwitterLoginClick},
            Button {bsSize: 'large'},
              i {className: "fa fa-twitter twitter-icon"}
              "Login with Twitter"
      Row {className: "blank"}
      Row {},
        Col md: 12,
          div {className: "logo"},
            img {src: logo, width: "80px"}
          h1 {}, "Learn and help as fast as you type."
          h3 {}, "Chatsignal is Slack x StackOverflow and a few more things you
            should know about."
      Row {},
        Col md: 12,
          Button {bsSize: 'large'}, "Start Chatting"
          Button {bsSize: 'large', href: "#real-time"}, "Learn More"

module.exports = MainLandingComponent
