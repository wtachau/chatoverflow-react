React = require "react"

{ ul, li, div } = React.DOM
Message = React.createFactory(require("./Message"))

MessageList = React.createClass
  propTypes: 
    messages: React.PropTypes.array.isRequired

  componentDidUpdate: (prevProps, prevState) ->
    component = React.findDOMNode(this)
    component.scrollTop = component.scrollHeight

  render: ->
    div {className: "messages"},
      @props.messages.map ({username, text}, index) ->
        Message username: username, text: text, key: index, index: index

module.exports = MessageList
