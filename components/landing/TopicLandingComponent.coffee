React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
{ div, h3, h4, i, img } = React.DOM

TopicLandingComponent = React.createClass
  displayName: "TopicLandingComponent"

  render: ->
    placeHolder = "../assets/images/placeHolder.png"
    div {className: "container topics"},
      Row {},
        Col md: 12,
          h3 {}, "Start chatting with popular topics"
      Row {},
        Col md: 12,
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
        Col md: 12,
          h4 {className: "subtitle"}, "For Designers"
          Col md: 1,
            img {src: placeHolder, width: "100px"}
          Col md: 1, mdOffset: 1,
            img {src: placeHolder, width: "100px"}
          Col md: 1, mdOffset: 1,
            img {src: placeHolder, width: "100px"}
          Col md: 1, mdOffset: 1,
            img {src: placeHolder, width: "100px"}

module.exports = TopicLandingComponent
