React = require "react"

{ ul, li, div } = React.DOM
Message = React.createFactory require("./Message")

MessageList = React.createClass
  propTypes: 
    messages: React.PropTypes.array.isRequired

  componentDidUpdate: (prevProps, prevState) ->
    component = React.findDOMNode(this)
    component.scrollTop = component.scrollHeight

  render: ->
    div {className: "messages"},
      @props.messages.map ({username, text}, index) ->
        oddClass = if index % 2 == 1 then "odd" else ""
        Message username: username, text: text, key: index, className: oddClass

module.exports = MessageList
