React = require("react")

ReactBootstrap = require("react-bootstrap")
moment = require("moment")
Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
{ p, img, video } = React.DOM

Message = React.createClass
  propTypes:
    username: React.PropTypes.string.isRequired
    text: React.PropTypes.string.isRequired
    index: React.PropTypes.number.isRequired

  getDate: ->
    myDate = new Date()
    currentTime = myDate.getHours() % 12 + ":" + myDate.getMinutes()
    if myDate.getHours() < 12 then currentTime + " AM" else currentTime + " PM"

  decorateText: (text) ->
    if text.match ///((^https?:\/\/.*\.(?:png|jpg|gif)$)){1}///
      return img {src: text}
    else if text.match ///((^https?:\/\/.*\.(?:gifv)$)){1}///
      return video {src: (text.replace "gifv", "mp4"), type: "video/mp4", preload: "auto", autoPlay: "autoplay", loop: "loop", muted: "muted"}
    else ""

  render: ->
    oddClass = if @props.index % 2 == 1 then "odd" else ""
    Row {style: {marginBottom: 10}, className: oddClass},
      Col xs: 1,
        p {className: "username"}, @props.username
      Col xs: 10,
        p {}, @props.text, @decorateText @props.text
      Col xs: 1,
        p {}, moment().format("h:mm A")

module.exports = Message
