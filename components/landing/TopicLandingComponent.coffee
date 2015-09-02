React          = require("react")
ReactBootstrap = require("react-bootstrap")
Row            = React.createFactory(ReactBootstrap.Row)
Col            = React.createFactory(ReactBootstrap.Col)

{ div, h3, h4, i, img, p } = React.DOM

TopicLandingComponent = React.createClass
  displayName: "TopicLandingComponent"

  render: ->
    placeHolder = "../assets/images/placeHolder.png"
    ios         = "../assets/images/cs-apple.png"
    java        = "../assets/images/cs-java.png"
    c_logo      = "../assets/images/cs-c++.png"
    ruby        = "../assets/images/cs-rails.png"
    uxui        = "../assets/images/cs-ui.png"
    research    = "../assets/images/cs-research.png"
    sketch      = "../assets/images/cs-sketch.png"
    interaction = "../assets/images/cs-interaction.png"
    div {className: "container topics"},
      Row {},
        Col md: 12,
          h3 {}, "Start chatting with popular topics"
      Row {},
        Col md: 12,
          h4 {className: "subtitle"}, "For Developers"
          div {className: "topic"},
            img {src: ios, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "iOS"
          div {className: "topic"},
            img {src: java, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "Java"
          div {className: "topic"},
            img {src: c_logo, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "C++"
          div {className: "topic"},
            img {src: ruby, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "Ruby"
      Row {},
        Col md: 12,
          h4 {className: "subtitle"}, "For Designers"
          div {className: "topic"},
            img {src: uxui, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "UX/UI"
          div {className: "topic"},
            img {src: sketch, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "Sketch"
          div {className: "topic"},
            img {src: interaction, width: "100px", className: "topic-image"}
            p {className: "topic-title"}, "Interaction"
          div {className: "topic"},
            img {src: research, width: "100px", height: "100px", className: "topic-image"}
            p {className: "topic-title"}, "Research"

module.exports = TopicLandingComponent
