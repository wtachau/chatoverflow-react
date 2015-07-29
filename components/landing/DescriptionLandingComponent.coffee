React = require("react")
ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
{ div, h3, p, img } = React.DOM

DescriptionLandingComponent = React.createClass
  displayName: "DescriptionLandingComponent"

  propTypes:
    id: React.PropTypes.string.isRequired
    title: React.PropTypes.string.isRequired
    image_src: React.PropTypes.string.isRequired

  render: ->
    div {className: "container description", id: @props.id},
      Row {},
        Col md: 6,
          h3 {}, @props.title
          p {},
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Aenean euismod bibendum laoreet. Proin gravida dolor sit amet
            lacus accumsan et viverra justo commodo. Proin sodales pulvinar
            tempor. Cum sociis natoque penatibus et magnis dis parturient
            montes, nascetur ridiculus mus. Nam fermentum, nulla luctus
            pharetra vulputate, felis tellus mollis orci, sed rhoncus
            sapien nunc eget odio."
        Col md: 4, mdOffset: 2,
          img {src: @props.image_src, width: "375px"}

module.exports = DescriptionLandingComponent
