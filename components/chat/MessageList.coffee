React = require("react")

{ div, button } = React.DOM
Message = React.createFactory require("./Message")
AppStore = require("../../stores/AppStore")
AppActions = require("../../actions/AppActions")
ChatStore = require("../../stores/ChatStore")
ChatActions = require("../../actions/ChatActions")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

MessageList = React.createClass
  displayName: "MessageList"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  propTypes:
    messages: React.PropTypes.array.isRequired
    currentRoom: React.PropTypes.string.isRequired

  followRoom: ->
    AppActions.followRoom @props.currentRoom, @props.isFollowingRoom

  buttonText: ->
    isFollowing = @props.isFollowingRoom @props.currentRoom
    if isFollowing then 'Unfollow Room' else "Follow Room"

  checkWindowScroll: (e)->
    target = event.target
    # height = Math.max target.clientHeight, (target.innerHeight || 0)
    scrollTop = target.scrollTop
    # offset = target.offsetHeight
    # console.log "height: #{height}, scroll: #{scrollTop}, offset: #{offset}"
    if scrollTop is 0
      console.log "fetching previous messages"
      console.log @state.chat.currentPage
      ChatActions.fetchRoomHistory @props.currentRoom,
                                    parseInt(@state.chat.currentPage) + 1

  render: ->
    userColorClass = if message.username is @state.app.user.username
      "usercolor"
    else
      ""

    div {className: "messages", onScroll: @checkWindowScroll},
      button {onClick: @followRoom}, @buttonText()
      @props.messages.map (message, index) ->
        Message { message, key: index, className: userColorClass }

module.exports = MessageList
