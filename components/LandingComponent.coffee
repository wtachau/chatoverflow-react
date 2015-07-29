React = require("react")
ReactBootstrap = require("react-bootstrap")
MainLandingComponent = React.createFactory require("./landing/MainLandingComponent")
TopicLandingComponent = React.createFactory require("./landing/TopicLandingComponent")
DescriptionLandingComponent = React.createFactory require("./landing/DescriptionLandingComponent")
LoginLandingComponent = React.createFactory require("./landing/LoginLandingComponent")
{ div } = React.DOM

LandingComponent = React.createClass
  displayName: "LandingComponent"

  propTypes:
    onLoginClick: React.PropTypes.func.isRequired

  render: ->
    div {className: "landing-body"},
      div {className: "purple"},
        MainLandingComponent {onLoginClick: @props.onLoginClick}
      div {},
        TopicLandingComponent {}
      div {className: "purple"},
        DescriptionLandingComponent {title: "Real problems, real time"}
      div {},
        DescriptionLandingComponent {title: "Problemsolve with experts"}
      div {className: "purple"},
        LoginLandingComponent {onLoginClick: @props.onLoginClick}

module.exports = LandingComponent
