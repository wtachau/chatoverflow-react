$                    = require("jquery")
React                = require("react")
ReactBootstrap       = require("react-bootstrap")
UserActions          = require("../../actions/UserActions")
UserStore            = require("../../stores/UserStore")
MentionStore         = require("../../stores/MentionStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
Router               = require("react-router")

AskComponent  = React.createFactory require("../AskComponent")
TopicSearch   = React.createFactory require("./TopicSearch")
TopicList     = React.createFactory require("./TopicList")
TopicListItem = React.createFactory require("./TopicListItem")
RoomList      = React.createFactory require("./RoomList")
RoomListItem  = React.createFactory require("./RoomListItem")
UserComponent = React.createFactory require("../UserComponent")
ListGroup     = React.createFactory ReactBootstrap.ListGroup
Badge         = React.createFactory ReactBootstrap.Badge
Nav           = React.createFactory ReactBootstrap.Nav
Link          = React.createFactory Router.Link

{ span, div, img, h3, i } = React.DOM

TopicSidebar = React.createClass
  displayName: "TopicSidebar"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      user: UserStore
      mention: MentionStore

  propTypes:
    user: React.PropTypes.object.isRequired

  onCloseRoom: (e) ->
    room_clicked = e.target.getAttribute("data-id")
    UserActions.followRoom room_clicked, @props.user
    e.preventDefault()

  onCloseTopic: (e) ->
    topic_clicked = e.target.getAttribute("data-id")
    UserActions.followTopic topic_clicked, @props.user
    e.preventDefault()

  badge: (room_id) ->
    if @state.mention.unread[parseInt(room_id)]
      Badge {}, 1
    else
      span {}, ""

  slideSidebarRight: ->
    $(".home").removeClass("ask-position-left").addClass("ask-position-right")
    $(".sidebar").removeClass("position-left").addClass("position-right")

  slideSidebarLeft: ->
    $(".home").removeClass("ask-position-right").addClass("ask-position-left")
    $(".sidebar").removeClass("position-right").addClass("position-left")

  render: ->
    div {},
      AskComponent {slideSidebarLeft: @slideSidebarLeft}

      ListGroup {className: "sidebar position-left"},

        div {className: "logo-div", onClick: @slideSidebarLeft},
          img {src: "../../assets/images/icon_placeholder.png", className: "logo"}
          Link to: "home",
            h3 {className: "categories-header"}, "ChatSignal"
        div {onClick: @slideSidebarLeft},
          TopicList
            topics: @props.user.followed_topics
            onClose: @onCloseTopic
            onClick: @slideSidebarLeft

          TopicSearch
            user: @props.user

          RoomList
            rooms: @props.user.followed_rooms
            onClose: @onCloseRoom
            badge: @badge

        div {className: "profile-and-new-thread"},
          div {className: "sidebar-profile"},
            UserComponent
              user: @props.user
              includeLogout: true
            div {className: "sidebar-username"}, @props.user?.username
          div {className: "new-thread", onClick: @slideSidebarRight},
            "New Thread",
            i {className: "fa fa-plus"}


module.exports = TopicSidebar
