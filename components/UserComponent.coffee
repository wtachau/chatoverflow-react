React = require("react")
ReactBootstrap = require("react-bootstrap")
UserActions = require("../actions/UserActions")
UserStore = require("../stores/UserStore")
BootstrapModal = require("react-bootstrap-modal")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")

Modal = React.createFactory BootstrapModal
ModalHeader = React.createFactory BootstrapModal.Header
ModalTitle = React.createFactory BootstrapModal.Title
ModalBody = React.createFactory BootstrapModal.Body
ModalFooter = React.createFactory BootstrapModal.Footer
Button = React.createFactory ReactBootstrap.Button
Thumbnail = React.createFactory ReactBootstrap.Thumbnail
Grid = React.createFactory ReactBootstrap.Grid
Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
{ a, div, img } = React.DOM

UserComponent = React.createClass
  displayName: "UserComponent"

  propTypes:
    user: React.PropTypes.object.isRequired
    includeLogout: React.PropTypes.bool

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: UserStore

  getInitialState: ->
    showModal: false

  showPopup: ->
    UserActions.fetchUsers()
    @setState showModal: true

  closePopup: -> @setState showModal: false

  render: ->
    div {className: "popup-link"},
      a {href: "#", onClick: @showPopup},
        img {src: @props.user.pic_url, className: "profile-pic"}
      Modal {show: @state.showModal, onHide: @closePopup, className: "user-modal"},
        ModalHeader {closeButton: true},
          ModalTitle {}, "User Information"
        ModalBody {},
          Grid {},
            Row {},
              Col {xs: 6, md: 3},
                div {className: "user-thumbnail"},
                  Thumbnail {href: "#", src: @props.user.pic_url}
              Col {xs: 6, md: 3},
                div {className: "user-username"}, "#{@props.user.username}"
                if @state.users
                  for user in @state.users
                    if user.username is @props.user.username
                      div {className: "user-karma"}, "Karma: #{user.karma or 0}"
        if @props.includeLogout
          ModalFooter {},
            Button {onClick: UserActions.logout, bsStyle: "danger"}, "Log out"


module.exports = UserComponent
