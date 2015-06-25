React = require "react"

{ ul, li } = React.DOM

MessageList = React.createClass
  propTypes: 
    messages: React.PropTypes.array.isRequired

  componentDidUpdate: (prevProps, prevState) ->
    component = React.findDOMNode(this)
    component.scrollTop = component.scrollHeight

  render: ->
    ul {className: "unordered-list-messages"},
      @props.messages.map ({username, text}) ->
        li {className: "messages"}, "#{username}: #{text}"

module.exports = MessageList
