React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h3, button, i } = React.DOM

LandingComponent = React.createClass
  displayName: "LandingComponent"

  propTypes:
    loginClicked: React.PropTypes.func.isRequired

  render: ->
    div {},
      div {},
        Row {},
          Col md: 1, mdOffset: 1,
            div {},
              h1 {}, "chatsignal"
          Col md: 1, mdOffset: 6,
            div {className:"register-button", onClick: @props.loginClicked},
              Button bsSize: 'large',
                i {className: "fa fa-github"}
                div {className: "login-text"}, "login with github"          
        Row {},
          Col md: 6, mdOffset: 1,
            div {},
              h1 {}, "Learn and help as fast as you type.",
            div {},
              "Chatsignal is Slack x StackOverflow and a few more things you 
              should know about."
      div {},
        Row {},
          Col md: 6, mdOffset: 1,
            h1 {}, "Start chatting with popular topics"
        Row {},
          Col md: 6, mdOffset: 1,
            h3 {}, "For Developers"
            div {},
              "<insert images here>"
        Row {},
          Col md: 6, mdOffset: 1,
            h3 {}, "For Designers"
            div {},
              "<insert images here>"
      div {},
        Row {},
          Col md: 4, mdOffset: 1,
            div {},
              h3 {}, "Real problems, real time"
            div {},
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
              Aenean euismod bibendum laoreet. Proin gravida dolor sit amet 
              lacus accumsan et viverra justo commodo. Proin sodales pulvinar 
              tempor. Cum sociis natoque penatibus et magnis dis parturient 
              montes, nascetur ridiculus mus. Nam fermentum, nulla luctus 
              pharetra vulputate, felis tellus mollis orci, sed rhoncus 
              sapien nunc eget odio."
          Col md: 2, mdOffset: 2,
            "<insert image here>"
      div {},
        Row {},
          Col md: 4, mdOffset: 1,
            div {},
              h3 {}, "Problemsolve with experts"
            div {},
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
              Aenean euismod bibendum laoreet. Proin gravida dolor sit amet 
              lacus accumsan et viverra justo commodo. Proin sodales pulvinar 
              tempor. Cum sociis natoque penatibus et magnis dis parturient 
              montes, nascetur ridiculus mus. Nam fermentum, nulla luctus 
              pharetra vulputate, felis tellus mollis orci, sed rhoncus 
              sapien nunc eget odio."
          Col {md: 2, mdOffset: 2},
            "<insert image here>"
      div {},
        Row {},
          Col md: 6, mdOffset: 3,
            div {},
              h3 {}, "Ready to be part of the conversation?"
          Col md: 6, mdOffset: 3,
            div {className:"register-button", onClick: @props.loginClicked},
              Button bsSize: 'large',
                i {className: "fa fa-github"}
                div {className: "login-text"}, "login with github"

module.exports = LandingComponent
