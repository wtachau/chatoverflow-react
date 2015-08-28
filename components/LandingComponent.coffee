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
    onGithubLoginClick: React.PropTypes.func.isRequired
    onTwitterLoginClick: React.PropTypes.func.isRequired

  render: ->
    div {className: "landing-body"},
      div {className: "skyline"},
        MainLandingComponent
          onTwitterLoginClick: @props.onTwitterLoginClick
          onGithubLoginClick: @props.onGithubLoginClick 
      div {},
        TopicLandingComponent {}
      div {className: "red"},
        DescriptionLandingComponent
          title: "Real problems, real time",
          id: "real-time",
          image_src: "../assets/images/real-time.png"
      div {},
        DescriptionLandingComponent
          title: "Problemsolve with experts",
          id: "problem-solve",
          image_src: "../assets/images/maze-icon.png"
      div {className: "red"},
        LoginLandingComponent
          onTwitterLoginClick: @props.onTwitterLoginClick
          onGithubLoginClick: @props.onGithubLoginClick


module.exports = LandingComponent
