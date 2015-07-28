React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h3, button, i ,br} = React.DOM

LandingComponent = React.createClass
  displayName: "LandingComponent"

  propTypes:
    loginClicked: React.PropTypes.func.isRequired

  render: ->
    div {} ,
      Row {},
        Col md: 1, mdOffset: 1,
          div {},
            h1, "chatsignal"
        Col md: 1, mdOffset: 6,
          div {className:"register-button", onClick: @props.loginClicked},
            Button bsSize: 'large',
              i {className: "fa fa-github"}
              div {className: "login-text"}, "login with github"          
      Row {},
        Col md: 6, mdOffset: 1,
          div {},
            h1, "Learn and help as fast as you type.",
          div {},
            h3, "Chatsignal is Slack x StackOverflow and a few more things you 
              should know about."
      Row {},
        Col md: 6, mdOffset: 3,
          div {},
            h1, "third row"
      # Col md: 6, mdOffset: 3,
      #   div {},
      #     h1 className: "center-block" , "chatsignal"
      #   div {},
      #     h3 className: "subtitle",
      #       i {}, "to the chat mobile! 2"
      #   div {className:"register-button", onClick: @props.loginClicked},
      #     Button bsSize: 'large',
      #       i {className: "fa fa-github"}
      #       div {className: "login-text"}, "login with github"

module.exports = LandingComponent
