React = require("react")
ReactBootstrap = require("react-bootstrap")
AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Modal = React.createFactory ReactBootstrap.Modal
ModalHeader = React.createFactory ReactBootstrap.Modal.Header
ModalTitle = React.createFactory ReactBootstrap.Modal.Title
ModalBody = React.createFactory ReactBootstrap.Modal.Body
ModalFooter = React.createFactory ReactBootstrap.Modal.Footer
Button = React.createFactory ReactBootstrap.Button
{ a, div, img } = React.DOM

UserComponent = React.createClass
  displayName: "UserComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: AppStore

  showPopup: ->
    AppActions.showUserPopup true

  closePopup: ->
    AppActions.showUserPopup false

  render: ->
    div {},
      a {href: "#", onClick: @showPopup}, @state.user.username
      Modal {show: @state.showUserPopup, onHide: @closePopup},
        ModalHeader {closeButton: true},
          ModalTitle {}, "User Information"
        ModalBody {},
          div {}, "Username: #{@state.user.username}"
          div {}, "Karma: #{@state.user.karma}"
          div {},
            "Picture: "
            img {className: "profile-pic", src: @state.user.pic_url}
        ModalFooter {},
          Button {onClick: @closePopup}, "Close"


module.exports = UserComponent
