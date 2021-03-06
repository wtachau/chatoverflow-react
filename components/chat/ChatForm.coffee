React                = require "react"
mentions             = require "react-mentions"
ReactBootstrap       = require "react-bootstrap"
ThreadActions        = require("../../actions/ThreadActions")
UserStore            = require("../../stores/UserStore")
URLResources         = require("../../common/URLResources")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

MentionsInput = React.createFactory mentions.MentionsInput
Mention       = React.createFactory mentions.Mention

{form} = React.DOM

ChatForm = React.createClass
  displayName: "ChatForm"

  propTypes:
    submitMessage: React.PropTypes.func.isRequired
    setMessage: React.PropTypes.func.isRequired
    message: React.PropTypes.string.isRequired
    users: React.PropTypes.array.isRequired

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: UserStore

  getInitialState: ->
    mentions: []
    keyPressMap: {}

  componentWillUnmount: ->
    ThreadActions.setCurrentRoom null

  keyPress: (e) ->
    @state.keyPressMap[e.key] = (e.type == "keydown")
    controlOrShift = @state.keyPressMap["Control"] or
                      @state.keyPressMap["Shift"]
    if @state.keyPressMap["Enter"] and controlOrShift
      @props.setMessage(@props.message + "\n")
    else if @state.keyPressMap["Enter"]
      @submit e

  submit: (e) ->
    for mention in @state.mentions
      if mention.display is "here"
        for user in @props.users
          unless user.username is @state.user.username
            @state.mentions.push
              display: user.username
              id: user.username
              index: mention.index
              plainTextIndex: mention.plainTextIndex
              type: null
        break
    @props.submitMessage e, @props.message.trim(), @state.mentions
    @props.setMessage ""

  displayMention: (id, display, type) -> "@" + display

  formattedUserMentionsData: () ->
    mentions = @props.users.map ({username, id}) ->
      {id: id + 1, display: username}
    mentions.unshift display: "here", id: 1
    for user, index in mentions
      if user.display is @state.user.username
        mentions.splice index, 1
        break
    mentions

  inputChange: (e, newValue, newPlainTextValue, mentions) ->
    component = React.findDOMNode this
    component.scrollTop = component.scrollHeight
    @props.setMessage e.target.value
    @setState mentions: mentions

  render: ->
    form {className: "chat-form", autoComplete: off},
      MentionsInput
        value: @props.message
        onChange: @inputChange
        displayTransform: @displayMention
        onKeyUp: @keyPress
        onKeyDown: @keyPress
        markup: "@[__display__](#)"
        placeholder: "Enter your response here."
        Mention {trigger: "@", data: @formattedUserMentionsData()}

module.exports = ChatForm
