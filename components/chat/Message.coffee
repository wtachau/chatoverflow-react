React = require("react")

ReactBootstrap = require("react-bootstrap")
Row = React.createFactory(ReactBootstrap.Row)
Col = React.createFactory(ReactBootstrap.Col)
{p} = React.DOM

Message = React.createClass
  propTypes:
    username: React.PropTypes.string.isRequired
    text: React.PropTypes.string.isRequired
    index: React.PropTypes.number.isRequired

  getDate: ->
    myDate = new Date()
    currentTime = myDate.getHours() % 12 + ":" + myDate.getMinutes()
    if myDate.geHours < 12 then currentTime + " AM" else currentTime + " PM"

  render: ->
    oddClass = if @props.index % 2 == 1 then "odd" else ""
    Row {style: {marginBottom: 10}, className: oddClass},
      Col xs: 1,
        p {className: "username"}, " " + @props.username
      Col xs: 10,
        p {}, @props.text
      Col xs: 1,
        p {}, @getDate()

module.exports = Message
