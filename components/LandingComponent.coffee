React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
Button = React.createFactory(ReactBootstrap.Button)
{ div, h1, h2, h3, h4, i, img, p } = React.DOM

LandingComponent = React.createClass
  displayName: "LandingComponent"

  propTypes:
    loginClicked: React.PropTypes.func.isRequired

  render: ->
    placeHolder = "../assets/images/placeHolder.png"
    div {className: "landing-body"},
      div {className: "main purple"},
        Row {},
          Col md: 1, mdOffset: 1,
            h2 {}, "chatsignal"
          Col md: 1, mdOffset: 7,
            div {onClick: @props.loginClicked},
              Button {bsSize: 'large'},
                i {className: "fa fa-github github-icon"}
                "Login with GitHub"
        Row {className: "blank"}
        Row {},
          Col md: 6, mdOffset: 1,
            h1 {}, "Learn and help as fast as you type."
            h3 {}, "Chatsignal is Slack x StackOverflow and a few more things you
              should know about."
        Row {},
          Col md: 6, mdOffset: 1,
            Button {bsSize: 'large'}, "Start Chatting"
            Button {bsSize: 'large'}, "Learn More"
      div {className: "second"},
        Row {},
          Col md: 8, mdOffset: 1,
            h3 {}, "Start chatting with popular topics"
        Row {},
          Col md: 8, mdOffset: 1,
            h4 {className: "subtitle"}, "For Developers"
            Col md: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
        Row {},
          Col md: 8, mdOffset: 1,
            h4 {className: "subtitle"}, "For Designers"
            Col md: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
            Col md: 1, mdOffset: 1,
              img {src: placeHolder, width: "100px"}
      div {className: "descriptions purple"},
        Row {},
          Col md: 4, mdOffset: 1,
            h3 {}, "Real problems, real time"
            p {},
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Aenean euismod bibendum laoreet. Proin gravida dolor sit amet
              lacus accumsan et viverra justo commodo. Proin sodales pulvinar
              tempor. Cum sociis natoque penatibus et magnis dis parturient
              montes, nascetur ridiculus mus. Nam fermentum, nulla luctus
              pharetra vulputate, felis tellus mollis orci, sed rhoncus
              sapien nunc eget odio."
          Col md: 2, mdOffset: 2,
            img {src: placeHolder}
      div {className: "descriptions"},
        Row {},
          Col md: 4, mdOffset: 1,
            h3 {}, "Problemsolve with experts"
            p {},
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Aenean euismod bibendum laoreet. Proin gravida dolor sit amet
              lacus accumsan et viverra justo commodo. Proin sodales pulvinar
              tempor. Cum sociis natoque penatibus et magnis dis parturient
              montes, nascetur ridiculus mus. Nam fermentum, nulla luctus
              pharetra vulputate, felis tellus mollis orci, sed rhoncus
              sapien nunc eget odio."
          Col {md: 2, mdOffset: 2},
            img {src: placeHolder}
      div {className: "bottomLogin purple"},
        Row {},
          Col md: 6, mdOffset: 3,
            h3 {}, "Ready to be part of the conversation?"
          Col md: 6, mdOffset: 3,
            div {className:"register-button", onClick: @props.loginClicked},
              Button bsSize: 'large',
                i {className: "fa fa-github"}
                div {className: "login-text"}, "Login with GitHub"

module.exports = LandingComponent
